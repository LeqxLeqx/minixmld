
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\
 *                                                                         *
 *  minixmld: a d wrapper for minixml                                      *
 *  copyright (c) 2018  leqxleqx                                           *
 *                                                                         *
 *  this program is free software: you can redistribute it and/or modify   *
 *  it under the terms of the gnu general public license as published by   *
 *  the free software foundation, either version 3 of the license, or      *
 *  (at your option) any later version.                                    *
 *                                                                         *
 *  this program is distributed in the hope that it will be useful,        *
 *  but without any warranty; without even the implied warranty of         *
 *  merchantability or fitness for a particular purpose.  see the          *
 *  gnu general public license for more details.                           *
 *                                                                         *
 *  you should have received a copy of the gnu general public license      *
 *  along with this program.  if not, see <http://www.gnu.org/licenses/>.  *
 *                                                                         *
\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */




module minixmld.c.xml_element;


import minixmld.c.baselib.list;
import minixmld.c.xml_attribute;


extern (C)
{

  struct XmlElement;

  XmlElement * xml_element_new(const char * name);
  XmlElement * xml_element_parse(const char * string);

  void xml_element_destroy(XmlElement * element);

  char * xml_element_get_name(XmlElement * element);
  List * xml_element_get_attributes(XmlElement * element);
  List * xml_element_get_children(XmlElement * element);
  List * xml_element_get_child_elements(XmlElement * element);
  bool xml_element_is_empty(XmlElement * element);

  XmlAttribute * xml_element_get_attribute(
        XmlElement * element,
        const char * name
      );

  XmlElement * xml_element_get_child(XmlElement * element, const char * name);
  XmlElement * xml_element_get_child_ignore_case(
        XmlElement * element,
        const char * name
      );

  List * xml_element_get_children_by_name(
        XmlElement * element,
        const char * name
      );
  List * xml_element_get_name_ignore_case(
        XmlElement * element,
        const char * name
      );

  char * xml_element_get_value(XmlElement * element);

  void xml_element_set_name(XmlElement * element, const char * name);
  void xml_element_set_value(XmlElement * element, const char * value);

  void xml_element_clear_attributes(XmlElement * element);
  void xml_element_clear_children(XmlElement * element);

  void xml_element_add_attribute(
        XmlElement * element,
        XmlAttribute * attribute
      );
  void xml_element_add_child(XmlElement * element, XmlElement * child);
  void xml_element_add_text(XmlElement * element, const char * text);

  void xml_element_add_attributes(XmlElement * element, List * attributes);
  void xml_element_add_children(XmlElement * element, List * children);




}


