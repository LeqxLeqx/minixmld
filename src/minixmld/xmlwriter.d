
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


module minixmld.xmlwriter;


import minixmld.c.xml_writer;

import minixmld.xmldocument;
import minixmld.xmlelement;
import minixmld.xmlutils;
public import minixmld.xmlwriterstyle;

import std.stdio;

alias c_XmlWriter = minixmld.c.xml_writer.XmlWriter;
alias c_XmlWriterStyle = minixmld.c.xml_writer.XmlWriterStyle;
alias d_XmlWriterStyle = minixmld.xmlwriterstyle.XmlWriterStyle;

class XmlWriter
{

  private c_XmlWriter * _writer;

  public this()
  {
    this._writer = xml_writer_new();
  }

  ~this()
  {
    xml_writer_destroy(this._writer);
  }

  public d_XmlWriterStyle getStyle()
  {
    return writerStyleFromC(xml_writer_get_style(this._writer));
  }

  public uint getIndentWidth()
  {
    return xml_writer_get_indent_width(this._writer);
  }

  public void setStyle(d_XmlWriterStyle style)
  {
    xml_writer_set_style(this._writer, writerStyleToC(style));
  }

  public void setIndentWidth(uint width)
  {
    xml_writer_set_indent_width(this._writer, width);
  }
  

  public string getDocumentText(XmlDocument document)
  {
    return toStringAndFree(
        xml_writer_get_document_text(this._writer, document._document)
        );
  }

  public string getElementText(XmlElement element)
  {
    return toStringAndFree(
        xml_writer_get_element_text(this._writer, element._element)
        );
  }

  public void writeDocument(XmlDocument document, File file)
  {
    xml_writer_write_document(this._writer, document._document, file.getFP());
  }

  public void writeElement(XmlElement element, File file)
  {
    xml_writer_write_element(this._writer, element._element, file.getFP());
  }
  
}




