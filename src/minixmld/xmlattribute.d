
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



module minixmld.xmlattribute;

import minixmld.c.xml_attribute;

import minixmld.xmlobject;

import core.stdc.stdlib;
import std.string;

alias c_XmlAttribute = minixmld.c.xml_attribute.XmlAttribute;


class XmlAttribute : XmlObject
{

  package c_XmlAttribute * _attribute;

  public this(string name, string value)
  {
    immutable(char) * namePtr, valuePtr;

    namePtr = name.toStringz();
    valuePtr = value.toStringz();

    this._attribute = xml_attribute_new(namePtr, valuePtr);
    this.hasOwner = false;
  }

  package this(c_XmlAttribute * attribute, bool hasOwner)
  {
    assert(attribute !is null);

    this._attribute = attribute;
    this.hasOwner = hasOwner;
  }

  protected override void destroy()
  {
    xml_attribute_destroy(this._attribute);
  }


  public string getName()
  {
    import minixmld.xmlutils;

    return toStringAndFree(xml_attribute_get_name(this._attribute));
  }

  public string getValue()
  {
    import minixmld.xmlutils;

    return toStringAndFree(xml_attribute_get_value(this._attribute));
  }

}




