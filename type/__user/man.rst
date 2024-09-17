cdist-type__user(7)
===================

NAME
----
cdist-type__user - Manage users


DESCRIPTION
-----------
This type allows you to create or modify users on the target.


OPTIONAL PARAMETERS
-------------------
comment
   see :strong:`usermod`\ (8)
gid
   see :strong:`usermod`\ (8)
home
   see :strong:`usermod`\ (8)
password
   see :strong:`usermod`\ (8)
shell
   see :strong:`usermod`\ (8)
state
   ``present`` or ``absent``

   Defaults to: ``present``
uid
   see :strong:`usermod`\ (8)


BOOLEAN PARAMETERS
------------------
create-home
   see :strong:`useradd`\ (8), applied only on user creation
remove-home
   see :strong:`userdel`\ (8), applied only on user deletion
system
   see :strong:`useradd`\ (8), applied only on user creation


MESSAGES
--------
mod
   User is modified
add
   New user added
userdel -r
   If user was deleted with homedir
userdel
   If user was deleted (keeping homedir)


EXAMPLES
--------

.. code-block:: sh

   # Create user account for foobar with operating system default settings
   __user foobar

   # Same but with a different shell
   __user foobar --shell /bin/zsh

   # Same but for a system account
   __user foobar --system

   # Set explicit uid and home
   __user foobar --uid 1001 --shell /bin/zsh --home /home/foobar

   # Drop user if exists
   __user foobar --state absent


SEE ALSO
--------
* :strong:`pw`\ (8) (FreeBSD)
* :strong:`usermod`\ (8)


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2011 Steven Armstrong, 2024 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
