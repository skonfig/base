cdist-type__clean_path(7)
=========================

NAME
----
cdist-type__clean_path - Remove files and directories in path recursively.


DESCRIPTION
-----------
Provided path must be a directory.

Arguments are passed to ``find(1)``.

Parent directory is always excluded.

This type is mostly POSIX compatible.


OPTIONAL PARAMETERS
-------------------
path
   Path to be cleaned. Defaults to ``$__object_id``.
onchange
   The code to run if something was removed.


OPTIONAL MULTIPLE PARAMETERS
----------------------------
rm-atime
    Same as :strong:`find`\ (1)'s ``-atime``.
rm-ctime
    Same as :strong:`find`\ (1)'s ``-ctime``.
rm-iname
    Same as :strong:`find`\ (1)'s ``-iname``.
rm-mtime
    Same as :strong:`find`\ (1)'s ``-mtime``.
rm-name
    Same as :strong:`find`\ (1)'s ``-name``.
rm-newer
    Same as :strong:`find`\ (1)'s ``-newer``.
rm-path
    Same as :strong:`find`\ (1)'s ``-path``.
rm-regex
    Same as :strong:`find`\ (1)'s ``-regex`` (not POSIX).
rm-type
    Same as :strong:`find`\ (1)'s ``-type``.
not-atime
    Same as :strong:`find`\ (1)'s ``! -atime``.
not-ctime
    Same as :strong:`find`\ (1)'s ``! -ctime``.
not-iname
    Same as :strong:`find`\ (1)'s ``! -iname``.
not-mtime
    Same as :strong:`find`\ (1)'s ``! -mtime``.
not-name
    Same as :strong:`find`\ (1)'s ``! -name``.
not-newer
    Same as :strong:`find`\ (1)'s ``! -newer``.
not-path
    Same as :strong:`find`\ (1)'s ``! -path``.
not-regex
    Same as :strong:`find`\ (1)'s ``! -regex`` (not POSIX).
not-type
    Same as :strong:`find`\ (1)'s ``! -type``.


EXAMPLES
--------

.. code-block:: sh

   # delete everything inside a directory
   __clean_path /tmp/very.temp


   # Debian: disable all apache2 conf's other than charset.conf and security.conf

   __clean_path /etc/apache2/conf-enabled \
       --not-name 'charset.conf' \
       --not-name 'security.conf' \
       --onchange 'service apache2 restart'

   __clean_path apache2-conf-enabled \
       --path /etc/apache2/conf-enabled \
       --not-name 'charset.conf' \
       --not-name 'security.conf' \
       --onchange 'service apache2 restart'


   # clean up __unpack backups after 90 days

   __unpack /some/thing.tar \
      --destination /some/where/something \
      --backup-destination

   require=__unpack/some/thing.tar \
   __clean_path /some/where/something.cdist__unpack_backup \
      --path /some/where \
      --rm-type d \
      --rm-name 'something.cdist__unpack_backup_*' \
      --rm-mtime +90


AUTHORS
-------
* Ander Punnar <ander-at-kvlt-dot-ee>
* Dennis Camera <dennis.camera-@-riiengineering.ch>


COPYING
-------
Copyright \(C) 2024 Ander Punnar, Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
