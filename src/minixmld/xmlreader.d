
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


module minixmld.xmlreader;

import minixmld.c.xml_reader;

import minixmld.xmldocument;
import minixmld.xmlelement;
import minixmld.xmlutils;

import std.string;

alias c_XmlReader = minixmld.c.xml_reader.XmlReader;
alias c_XmlElement = minixmld.c.xml_element.XmlElement;
alias c_XmlDocument = minixmld.c.xml_document.XmlDocument;


class XmlReader
{

  private c_XmlReader * _reader;

  public this()
  {
    this._reader = xml_reader_new();
  }

  ~this()
  {
    xml_reader_destroy(this._reader);
  }

  public string getErrorMessage()
  {
    return toStringAndFree(xml_reader_get_error_message(this._reader));
  }

  public XmlDocument parseDocument(void[] data)
  {
    c_XmlDocument * ret;

    ret = xml_reader_parse_document(
          this._reader,
          cast(char *) data.ptr,
          data.length
          );
    if (ret is null)
      return null;
    else
      return new XmlDocument(ret);
  }

  public XmlElement parseElement(string data)
  {
    c_XmlElement * ret;

    ret = xml_reader_parse_element(this._reader, data.toStringz());

    if (ret is null)
      return null;
    else
      return new XmlElement(ret, false);
  }
  

}



