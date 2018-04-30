
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


module minixmld.xmldocument;


import minixmld.xmlelement;
import minixmld.minixmlexception;

import minixmld.c.xml_document;

import std.string;


alias c_XmlDocument = minixmld.c.xml_document.XmlDocument;
alias c_XmlElement = minixmld.c.xml_element.XmlElement;

class XmlDocument
{

  public static XmlDocument parse(void[] data)
  {
    c_XmlDocument * doc =xml_document_parse(
          cast(char *) data.ptr,
          data.length
        );

    if (doc is null)
      throw new MiniXmlException("failed to parse XML document");

    return new XmlDocument(doc);
  }


  package c_XmlDocument * _document;

  this()
  {
    this._document = xml_document_new();
  }

  this(XmlElement root)
  {
    assert(root !is null);
    assert(!root.hasOwner);

    this._document = xml_document_new_with_root(root._element);
  }

  package this(c_XmlDocument * document)
  {
    assert(document !is null);

    this._document = document;
  }

  ~this()
  {
    xml_document_destroy(this._document);
  }


  XmlElement getRoot()
  {
    return new XmlElement(
        xml_document_get_root(this._document),
        true
      );
  }


  string getEncoding()
  {
    import minixmld.xmlutils;

    return toStringAndFree(xml_document_get_encoding(this._document));
  }
  string getVersion()
  {
    import minixmld.xmlutils;

    return toStringAndFree(xml_document_get_version(this._document));
  }

  void setVersion(string _version)
  {
    xml_document_set_version(this._document, _version.toStringz());
  }
  void setEncoding(string encoding)
  {
    xml_document_set_encoding(this._document, encoding.toStringz());
  }


}



