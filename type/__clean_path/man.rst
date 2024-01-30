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
rm-name
    Same as ``-name``.
rm-path
    Same as ``-path``.
rm-regex
    Same as ``-regex`` (not POSIX).
not-name
    Same as ``! -name``.
not-path
    Same as ``! -path``.
not-regex
    Same as ``! -regex`` (not POSIX).


EXAMPLES
--------

.. code-block:: sh

   __clean_path /etc/apache2/conf-enabled \
       --not-name 'charset.conf' \
       --not-name 'security.conf' \
       --onchange 'service apache2 restart'

   __clean_path apache2-conf-enabled \
       --path /etc/apache2/conf-enabled \
       --not-name 'charset.conf' \
       --not-name 'security.conf' \
       --onchange 'service apache2 restart'


AUTHORS
-------
* Ander Punnar <ander-at-kvlt-dot-ee>


COPYING
-------
Copyright \(C) 2024 Ander Punnar.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
