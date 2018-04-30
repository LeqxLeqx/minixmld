
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


module minixmld.c.xml_writer;

import minixmld.c.xml_document;
import minixmld.c.xml_element;

import core.stdc.stdio;


extern (C)
{

  struct XmlWriter;

  enum XmlWriterStyle
  {
    XML_WRITER_STYLE_STANDARD = 0,
    XML_WRITER_STYLE_COMPRESSED = 1,
    XML_WRITER_STYLE_EXPANDED = 2,
  }

  XmlWriter * xml_writer_new();
  void xml_writer_destroy(XmlWriter * writer);

  XmlWriterStyle xml_writer_get_style(XmlWriter * writer);
  uint xml_writer_get_indent_width(XmlWriter * writer);

  void xml_writer_set_style(XmlWriter * writer, XmlWriterStyle style);
  void xml_writer_set_indent_width(XmlWriter * writer, uint width);


  char * xml_writer_get_document_text(
      XmlWriter * writer,
      XmlDocument * document
      );
  char * xml_writer_get_element_text(
      XmlWriter * writer,
      XmlElement * element
      );

  void xml_writer_print_document(
      XmlWriter * writer,
      XmlDocument * document,
      char * str
      );
  void xml_writer_printn_document(
      XmlWriter * writer, XmlDocument * document,
      char * str,
      uint n
      );

  void xml_writer_print_element(
      XmlWriter * writer,
      XmlElement * element,
      const char * str
      );
  void xml_writer_printn_element(
      XmlWriter * writer,
      XmlElement * element,
      char * str,
      uint n
      );

  void xml_writer_write_document(
      XmlWriter * writer,
      XmlDocument * document,
      FILE * stream
      );
  void xml_writer_write_element(
      XmlWriter * writer,
      XmlElement * element,
      FILE * stream
      );

}
