cdist-type__file(7)
===================

NAME
----
cdist-type__file - Manage files.


DESCRIPTION
-----------
This type allows you to create files, remove files and set file
attributes on the target.

If the file already exists on the target, then if it is a:

regular file, and state is:
   present
     replace it with the source file if they are not equal
   exists
     do nothing
symlink
   replace it with the source file or remove
directory
   replace it with the source file

One exception is that when state is pre-exists, an error is raised if
the file would have been created otherwise (e.g. it is not present or
not a regular file).

In any case, make sure that the file attributes are as specified.


OPTIONAL PARAMETERS
-------------------
group
   Group to :strong:`chgrp`\ (1) to.

   Defaults to: ``root``
mode
   Unix permissions, suitable for chmod.

   Defaults to: ``0600``
onchange
   Execute the given command after the file was modified (if it had to be
   modified).

   Can be used multiple times to execute multiple commands.
   The commands will be executed in the order the parameters are specified.
owner
   User to :strong:`chown`\ (1) to.

   Defaults to: ``root``
source
   If supplied, copy this file from the config host to the target.
   If not supplied, an empty file or directory will be created.
   If source is ``-`` (dash), take what was written to stdin as the file content.
state
   One of:

   present
      the file is exactly the one from source
   absent
      the file does not exist
   exists
      the file from source but only if it doesn't already exist
   pre-exists
      check that the file exists and is a regular file, but do not
      create or modify it

   Defaults to: ``present``


MESSAGES
--------
chgrp <group>
   Changed group membership
chown <owner>
   Changed owner
chmod <mode>
   Changed mode
create
   Empty file was created (no ``--source`` specified)
remove
   File exists, but state is absent, file will be removed by generated code.
upload
   File was uploaded


EXAMPLES
--------

.. code-block:: sh

   # Use __file from another type
   __file /etc/issue \
      --source "${__type:?}/files/archlinux"
      --state present

   # Supply some more settings
   __file /etc/shadow \
      --owner root --group shadow --mode 0640 \
      --state present \
      --source "${__type:?}/files/shadow"

   # Provide a default file, but let the user change it
   __file /home/frodo/.bashrc \
      --state exists \
      --owner frodo --mode 0600 \
      --source /etc/skel/.bashrc

   # Check that the file is present, show an error when it is not
   __file /etc/somefile --state pre-exists

   # Take file content from stdin
   __file /tmp/whatever \
      --owner 0 --group 0 --mode 0644 \
      --source - <<'EOF'
   Here goes the content for /tmp/whatever
   EOF


AUTHORS
-------
* Nico Schottelius <nico-cdist--@--schottelius.org>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2011-2013 Nico Schottelius.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
