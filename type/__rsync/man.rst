cdist-type__rsync(7)
====================

NAME
----
cdist-type__rsync - Mirror directories using ``rsync``


DESCRIPTION
-----------
The purpose of this type is to bring power of :strong:`rsync`\ (1) into
:strong:`skonfig`\ (1).


REQUIRED PARAMETERS
-------------------
source
   Source directory on the local machine.

   If ``--source`` is a directory, a slash (``/``) will be added to source and
   destination paths.


OPTIONAL MULTIPLE PARAMETERS
----------------------------
option
   Pass additional options to ``rsync``.
   See ``rsync(1)`` for all possible options.

   Due to a `bug in Python's argparse<https://bugs.python.org/issue9334>`_,
   the value must be prefixed with ``\``.

   Defaults to: ``--links``, ``--perms``, ``--recursive``, ``--times``


OPTIONAL PARAMETERS
-------------------
destination
   Destination directory.

   Defaults to: ``__object_id``
group
   Will be passed to ``rsync`` as ``--chown=:GROUP``.
   Read :strong:`rsync`\ (1) for more details.
mode
   Will be passed to ``rsync`` as ``--chmod=MODE``.
   Read :strong:`rsync`\ (1) for more details.
onchange
   Command to run in target after sync.
options
   Due to a `bug in Python's argparse<https://bugs.python.org/issue9334>`_,
   the value must be prefixed with ``\``.

   This parameter is deprecated, please use ``--option`` instead.
owner
   Will be passed to ``rsync`` as ``--chown=OWNER``.
   Read :strong:`rsync`\ (1) for more details.
remote-user
   Defaults to: ``root``


MESSAGES
--------
synced
   Sync happened.


EXAMPLES
--------

.. code-block:: sh

   __rsync /var/www/example.com \
      --owner root \
      --group www-data \
      --mode 'D750,F640' \
      --source "${__files:?}/example.com/www"


AUTHORS
-------
* Ander Punnar <ander-at-kvlt-dot-ee>


COPYING
-------
Copyright \(C) 2021 Ander Punnar.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
