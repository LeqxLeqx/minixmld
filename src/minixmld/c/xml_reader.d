
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


module minixmld.c.xml_reader;

import minixmld.c.xml_document;
import minixmld.c.xml_element;

extern (C)
{
  struct XmlReader;

  XmlReader * xml_reader_new();
  void xml_reader_destroy(XmlReader * reader);

  char * xml_reader_get_error_message(XmlReader * reader);

  XmlDocument * xml_reader_parse_document(
      XmlReader * reader,
      char * data,
      size_t data_size
      );

  XmlElement * xml_reader_parse_element(
      XmlReader * reader,
      const char * data
      );
}


