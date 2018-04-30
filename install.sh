#!/bin/bash

if [[ $UID != 0 ]] ; then
  echo must run as root
  exit 1
fi

if [[ !(-e bin/libminixmld.so) ]] ; then
  echo no file found at bin/libminixmld.so
  exit 2
fi


if [[ (-e /usr/include/minixmld) ]] ; then
  rm -r /usr/include/minixmld

  if [[ $? != 0 ]] ; then
    echo failed to remove old include directory at /usr/include/minixmld/A
    exit 4
  fi
fi

cp ./bin/libminixmld.so /usr/lib/libminixmld.so

if [[ $? != 0 ]] ; then
  echo failed to copy shared object file to /usr/lib/libminixmld.so
  exit 4
fi

cp -r ./src/minixmld /usr/include/minixmld

if [[ $? != 0 ]] ; then
  echo failed to copy new include directory to /usr/include/minixmld
  exit 4
fi


exit 0

