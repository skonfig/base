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
   See :strong:`rsync`\ (1) for all possible options.

   Due to a `bug in Python's argparse<https://bugs.python.org/issue9334>`_,
   the value must be prefixed with ``\``.

   The options passed to this parameter will be appended to the defaults listed
   below. If you don't want to use these default options, use the
   ``--no-defaults`` parameter, too.

   Defaults to: ``--links``, ``--perms``, ``--recursive``, ``--times``


OPTIONAL PARAMETERS
-------------------
destination
   Destination directory.

   Defaults to: ``__object_id``
group
   Will be passed to ``rsync`` as ``--chown=:GROUP``.
   Read :strong:`rsync`\ (1) for more details.
   Requires rsync >= 3.1.0.
mode
   Will be passed to ``rsync`` as ``--chmod=MODE``.
   Read :strong:`rsync`\ (1) for more details.
   Requires rsync >= 2.6.7; numeric modes (e.g. `--chmod=644,D755`) require
   rsync >= 3.1.0.
onchange
   Command to run in target after sync.
options
   Due to a `bug in Python's argparse<https://bugs.python.org/issue9334>`_,
   the value must be prefixed with ``\``.

   This parameter is deprecated, please use the ``--option`` and
   ``--no-defaults`` parameters instead.
owner
   Will be passed to ``rsync`` as ``--chown=OWNER``.
   Read :strong:`rsync`\ (1) for more details.
   Requires rsync >= 3.1.0.
remote-user
   Defaults to: ``root``


BOOLEAN PARAMETERS
------------------
no-defaults
   Clear the default options passed to :strong:`rsync`\ (1).

   cf. also ``--option``


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
* Ander Punnar <ander--@--kvlt.ee>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2021 Ander Punnar, 2023-2024 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
