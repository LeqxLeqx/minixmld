
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\
 *                                                                         *
 *  minixmld: a D wrapper for minixml                                      *
 *  Copyright (C) 2018  LeqxLeqx                                           *
 *                                                                         *
 *  This program is free software: you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by   *
 *  the Free Software Foundation, either version 3 of the License, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  This program is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *  GNU General Public License for more details.                           *
 *                                                                         *
 *  You should have received a copy of the GNU General Public License      *
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.  *
 *                                                                         *
\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


module minixmld.xmlutils;

import minixmld.minixmlexception;
import minixmld.xmlelement;
import minixmld.xmlnode;
import minixmld.xmlobject;
import minixmld.xmltext;

import minixmld.c.baselib.any;
import minixmld.c.baselib.list;
import minixmld.c.xml_utils;

import core.stdc.stdlib;
import core.stdc.string;

import std.string;

alias c_XmlElement = minixmld.c.xml_element.XmlElement;


class XmlUtils
{
  
  string escapeString(string str, bool attribute)
  {
    return toStringAndFree(xml_utils_escape_string(str.toStringz(), attribute));
  }

}



package XmlNode anyToXmlNode(Any any, bool hasOwner)
{
  if (any.type == AnyType.POINTER)
    return new XmlElement(cast(c_XmlElement *) any_to_ptr(any), hasOwner);
  else if (any.type == AnyType.STRING)
    return new XmlText(toStringAndFree(any_to_str(any)));
  else
    throw new MiniXmlException("unanticipated any type: %d", any.type);
}

package Any xmlNodeToAny(XmlNode node)
{
  char * textPtr;
  string text;

  if (node.nodeType == XmlNodeType.ELEMENT)
    return ptr_to_any((cast(XmlElement) node)._element);
  else if (node.nodeType == XmlNodeType.TEXT)
  {
    text = node.toString();
        /+ assumes sizeof(char) == 1 +/
    textPtr = cast(char *) malloc(text.length + 1);
    memcpy(textPtr, text.ptr, text.length);
    textPtr[text.length] = '\0';

    return str_to_any(textPtr);
  }
  else
    throw new MiniXmlException("unanticipated node type: %d", node.nodeType);
}

package string toStringAndFree(char * ptr)
{
  import std.conv;

  string str = to!string(ptr);
  free(ptr);

  return str;
}

package T[] toArrayAndDestroy(T)(List * list, T function(Any) initer)
{
  uint length;
  Any any;
  T[] ret;
 
  length = list_size(list);

  for (uint k = 0; k < length; k++)
  {
    any = list_get(list, k);
    ret ~= initer(any);
  }

  list_destroy(list);

  return ret;
}

package void assertNoOwner(T : XmlObject)(T[] array)
{
  foreach (T t ; array)
  {
    assert(!t.hasOwner);
  }
}

package List * toList(T)(T[] array, Any function(T) initer)
{
  List * ret = cast(List *) linked_list_new();

  foreach (T t ; array)
  {
    list_add(ret, initer(t));
  }

  return ret;
}

package void setOwnershipOfAll(T : XmlObject)(T[] array, bool value)
{
  foreach (T t ; array)
  {
    t.hasOwner = value;
  }
}


