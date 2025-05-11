cdist-type__group(7)
====================

NAME
----
cdist-type__group - Manage groups


DESCRIPTION
-----------
This cdist type allows you to create or modify groups on the target.


OPTIONAL PARAMETERS
-------------------
gid
   see groupmod(8)
password
   see above
state
   absent or present, defaults to present


BOOLEAN PARAMETERS
------------------
system
   see groupadd(8), apply only on group creation


MESSAGES
--------
``add``
   New group created/added
``mod``
   Existing group modified
``change <property> <new_value> <current_value>``
   Changed group ``property`` from ``current_value`` to ``new_value``
``remove`` (deprecated, use ``del`` instead)
   Group removed
``del``
   Group deleted


EXAMPLES
--------

.. code-block:: sh

   # Create a group 'foobar' with operating system default settings
   __group foobar

   # Remove the 'foobar' group
   __group foobar --state absent

   # Create a system group 'myservice' with operating system default settings
   __group myservice --system

   # Same but with a specific gid
   __group foobar --gid 1234

   # Same but with a gid and password
   __group foobar --gid 1234 --password 'crypted-password-string'


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2011-2015 Steven Armstrong, 2019-2025 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
