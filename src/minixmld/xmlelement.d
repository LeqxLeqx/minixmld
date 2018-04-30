
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


module minixmld.xmlelement;

import minixmld.xmlattribute;
import minixmld.xmlnode;

import minixmld.c.baselib.any;
import minixmld.c.baselib.list;
import minixmld.c.xml_element;

import std.string;
import core.stdc.stdlib;

alias c_XmlElement = minixmld.c.xml_element.XmlElement;
alias c_XmlAttribute = minixmld.c.xml_element.XmlAttribute;


class XmlElement : XmlNode
{

  public static XmlElement parse(string str)
  {
    c_XmlElement * _element = xml_element_parse(str.toStringz()); 

    return new XmlElement(_element, false);
  }


  package c_XmlElement * _element;

  public this (string name)
  {
    super(XmlNodeType.ELEMENT);

    immutable(char) * namePtr = name.toStringz();

    this._element = xml_element_new(namePtr);
    this.hasOwner = false;
  }

  package this (c_XmlElement * element, bool hasOwner)
  {
    super(XmlNodeType.ELEMENT);

    assert(element !is null);

    this._element = element;
    this.hasOwner = hasOwner;
  }


  protected override void destroy()
  {
    xml_element_destroy(this._element);
  }


  public string getName()
  {
    import minixmld.xmlutils;

    return toStringAndFree(xml_element_get_name(this._element));
  }

  public XmlAttribute[] getAttributes()
  {
    import minixmld.xmlutils;

    return toArrayAndDestroy!XmlAttribute(
        xml_element_get_attributes(this._element),
        any => new XmlAttribute(cast(c_XmlAttribute *) any_to_ptr(any), true)
      );
  }

  public XmlNode[] getChildren()
  {
    import minixmld.xmlutils;

    return toArrayAndDestroy!XmlNode(
        xml_element_get_children(this._element),
        any => anyToXmlNode(any, true)
      );
  }

  public XmlElement[] getChildElements()
  {
    import minixmld.xmlutils;

    return toArrayAndDestroy!XmlElement(
        xml_element_get_child_elements(this._element),
        any => new XmlElement(cast(c_XmlElement *) any_to_ptr(any), true)
      );
  }

  public bool isEmpty()
  {
    return xml_element_is_empty(this._element);
  }

  public XmlAttribute getAttribute(string name)
  {
    return new XmlAttribute(
          xml_element_get_attribute(this._element, name.toStringz()),
          true
        );
  }

  public XmlElement getChild(string name)
  {
    return new XmlElement(
        xml_element_get_child(this._element, name.toStringz()),
        true
      );
  }

  public XmlElement getChildIgnoreCase(string name)
  {
    return new XmlElement(
        xml_element_get_child_ignore_case(this._element, name.toStringz()),
        true
      );
  }

  public XmlElement[] getChildrenByName(string name)
  {
    import minixmld.xmlutils;
    
    return toArrayAndDestroy!XmlElement(
        xml_element_get_children_by_name(this._element, name.toStringz()),
        any => new XmlElement(cast(c_XmlElement *) any_to_ptr(any), true)
      );
  }

  public XmlElement[] getChildrenByNameIgnoreCase(string name)
  {
    import minixmld.xmlutils;

    return toArrayAndDestroy!XmlElement(
        xml_element_get_children_by_name(this._element, name.toStringz()),
        any => new XmlElement(cast(c_XmlElement *) any_to_ptr(any), true)
      );
  }

  public string getValue()
  {
    import minixmld.xmlutils;

    return toStringAndFree(xml_element_get_value(this._element));
  }

  public void setName(string name)
  {
    xml_element_set_name(this._element, name.toStringz());
  }

  public void setValue(string value)
  {
    xml_element_set_value(this._element, value.toStringz());
  }

  public void clearAttributes()
  {
    xml_element_clear_attributes(this._element);
  }

  public void clearChildren()
  {
    xml_element_clear_children(this._element);
  }

  public void addAttribute(XmlAttribute attr)
  {
    assert(!attr.hasOwner);

    xml_element_add_attribute(this._element, attr._attribute);
    attr.hasOwner = true;
  }

  public void addChild(XmlElement element)
  {
    assert(!element.hasOwner);

    xml_element_add_child(this._element, element._element);
    element.hasOwner = true;
  }

  public void addText(string text)
  {
    xml_element_add_text(this._element, text.toStringz());
  }

  public void addAttributes(XmlAttribute[] attributes)
  {
    import minixmld.xmlutils;

    List * list;

    assertNoOwner(attributes);
    list = toList!XmlAttribute(attributes, attr => ptr_to_any(attr._attribute));
    xml_element_add_attributes(this._element, list);
    list_destroy(list);
  }

  public void addChildren(XmlNode[] nodes)
  {
    import minixmld.xmlutils;

    List * list;
    Any any;

    assertNoOwner(nodes);
    list = toList!XmlNode(nodes, node => xmlNodeToAny(node));
    xml_element_add_children(this._element, list);

    for (uint k = 0; k < list_size(list); k++)
    {
      any = list_get(list, k);
      if (any.type == AnyType.STRING)
        free(any_to_str(any));
    }
    setOwnershipOfAll!XmlNode(nodes, true);

    list_destroy(list);
  }


}




