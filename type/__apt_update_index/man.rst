cdist-type__apt_update_index(7)
===============================

NAME
----
cdist-type__apt_update_index - Update APT package index


DESCRIPTION
-----------
This type will update APT package index if any of following is true:

* ``/var/lib/apt/lists`` is missing.
* ``/etc/apt/`` content is newer than ``/var/lib/apt/lists/`` (type will
  :strong:`touch`\ (1) it after every update).
* Package index cache is missing or older than ``--maxage``.
* ``--always`` parameter is set.


OPTIONAL PARAMETERS
-------------------
maxage
   Update is skipped if maximum age (in seconds) of package index cache is not
   reached yet.

   Defaults to: 86400


BOOLEAN PARAMETERS
------------------
always
   Always update package index.


EXAMPLES
--------

.. code-block:: sh

   __apt_update_index


SEE ALSO
--------
* :strong:`cdist-type__package_apt`\ (7)


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>


COPYING
-------
Copyright \(C) 2011 Steven Armstrong.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
