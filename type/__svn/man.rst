cdist-type__svn(7)
==================

NAME
----
cdist-type__svn -  Get and or keep Subversion repositories up-to-date


DESCRIPTION
-----------
This cdist type allows you to check out Subversion (SVN) repositories.


REQUIRED PARAMETERS
-------------------
source
   the SVN repository to check out.
   The value may be a subdirectory of the repository to check out.


OPTIONAL PARAMETERS
-------------------
group
   Group to :strong:`chgrp`\ (1) all the files in the working copy to.
mode
   Unix mode to set for all the files in the working copy.

   Format: suitable for :strong:`chmod`\ (1)
owner
   User to :strong:`chown`\ (1) all the files in the working copy to.
password
   Password of ``--username``.

   *Security note:* if possible it should be avoided to use the ``--username``
   and ``--password`` parameters because the password will be copied to the
   target host in plain text.
   If possible it is advisable to use SSH "deploy keys" instead.
state
   One of

   ``present``
      a working copy of ``--source`` exists at ``__object_id``.
   ``absent```
      No directory exists at ``__object_id``.

   Defaults to: ``present``
username
   Username to use to authenticate to SVN server.


EXAMPLES
--------

.. code-block:: sh

   # e.g., check out the WebKit SVN repository to /usr/src/webkit-svn
   __svn /usr/src/webkit-svn --source https://svn.webkit.org/repository/webkit/


SEE ALSO
--------
* :strong:`cdist-type__git`\ (7)


AUTHORS
-------
* Dennis Camera <dennis.camera--@--ssrq-sds-fds.ch>


COPYING
-------
Copyright \(C) 2021-2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
