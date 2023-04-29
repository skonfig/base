cdist-type__link(7)
===================

NAME
----
cdist-type__link - Manage links (hard and symbolic)


DESCRIPTION
-----------
This cdist type allows you to manage hard and symbolic links.
The ``__object_id`` is the destination for the link.


REQUIRED PARAMETERS
-------------------
source
   Specifies the link source.
type
   One of:

   hard
      create a hard link
   symbolic
      create a symbolic link


OPTIONAL PARAMETERS
-------------------
state
   One of:

   present
      the link exists
   absent
      the link does not exist

   Defaults to: ``present``


MESSAGES
--------
created <destination>
   Link to destination was created.
removed <destination>
   Link to destination was removed.
removed <destination> (directory)
   Destination was removed because ``--state present`` and destination was a
   directory.
removed <destination> (wrongsource)
   Destination was removed because ``--state present`` and destination link
   source was wrong.


EXAMPLES
--------

.. code-block:: sh

   # Create hard link of /etc/shadow
   __link /root/shadow --source /etc/shadow --type hard

   # Relative symbolic link
   __link /etc/apache2/sites-enabled/www.test.ch \
      --source ../sites-available/www.test.ch \
      --type symbolic

   # Absolute symbolic link
   __link /opt/plone \
      --source /home/services/plone \
      --type symbolic

   # Remove link
   __link /opt/plone --state absent


AUTHORS
-------
* Nico Schottelius <nico-cdist--@--schottelius.org>


COPYING
-------
Copyright \(C) 2011-2012 Nico Schottelius.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
