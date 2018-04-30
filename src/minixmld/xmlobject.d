
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


module minixmld.xmlobject;

public abstract class XmlObject
{

  private bool _hasOwner;

  package void hasOwner(bool value)
  {
    this._hasOwner = value;
  }

  public bool hasOwner()
  {
    return this._hasOwner;
  }

  ~this()
  {
    if (!hasOwner)
      destroy();
  }

  protected abstract void destroy();

}



