
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


module minixmld.xmlwriterstyle;

import minixmld.c.xml_writer;

alias c_XmlWriterStyle = minixmld.c.xml_writer.XmlWriterStyle;

enum XmlWriterStyle
{
  STANDARD,
  COMPRESSED,
  EXPANDED
}

package XmlWriterStyle writerStyleFromC(c_XmlWriterStyle cStyle)
{
  switch (cStyle)
  {
    case c_XmlWriterStyle.XML_WRITER_STYLE_STANDARD:
      return XmlWriterStyle.STANDARD;
    case c_XmlWriterStyle.XML_WRITER_STYLE_COMPRESSED:
      return XmlWriterStyle.COMPRESSED;
    case c_XmlWriterStyle.XML_WRITER_STYLE_EXPANDED:
      return XmlWriterStyle.EXPANDED;

    default:
      assert(0, "no such XmlWriterStyle programmed");
  }
}

package c_XmlWriterStyle writerStyleToC(XmlWriterStyle dStyle)
{
  switch (dStyle)
  {
    case XmlWriterStyle.STANDARD:
      return c_XmlWriterStyle.XML_WRITER_STYLE_STANDARD;
    case XmlWriterStyle.COMPRESSED:
      return c_XmlWriterStyle.XML_WRITER_STYLE_COMPRESSED;
    case XmlWriterStyle.EXPANDED:
      return c_XmlWriterStyle.XML_WRITER_STYLE_EXPANDED;

    default:
      assert(0, "no such XmlWriterStyle programmed");
  }
}




