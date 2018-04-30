
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


module minixmld.c.baselib.any;

extern (C)
{

  enum AnyType
  {
    POINTER  = 0xF,
    STRING   = 0x10
  }

  union _Any
  {
    char * str;
    void * ptr;

    /* TODO : THE REST */
  }

  struct Any
  {
    AnyType type;
    _Any value;
  }

  Any ptr_to_any(void * v);
  void * any_to_ptr(Any any);

  Any str_to_any(const char * str);
  char * any_to_str(Any any);

}


