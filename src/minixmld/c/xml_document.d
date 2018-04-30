
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




module minixmld.c.xml_document;

import minixmld.c.xml_element;

extern (C)
{

  struct XmlDocument;

  XmlDocument * xml_document_new();
  XmlDocument * xml_document_new_with_root(XmlElement * root);
  XmlDocument * xml_document_parse(char * str, size_t str_length);

  void xml_document_destroy(XmlDocument * document);

  XmlElement * xml_document_get_root(XmlDocument * document);
  char * xml_document_get_encoding(XmlDocument * document);
  char * xml_document_get_version(XmlDocument * document);

  void xml_document_set_encoding(XmlDocument * document, const char * encoding);
  void xml_document_set_version(XmlDocument * document, const char * _version);

}



