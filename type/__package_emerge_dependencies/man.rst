cdist-type__package_emerge_dependencies(7)
==========================================

NAME
----
cdist-type__package_emerge_dependencies - Install dependencies for
:strong:`cdist-type__package_emerge`\ (7)


DESCRIPTION
-----------
Portage is usually used on the Gentoo distribution to manage packages.
This type installs the following tools which are required by
:strong:`cdist-type__package_emerge`\ (7) to work:

* app-portage/flaggie
* app-portage/gentoolkit


EXAMPLES
--------

.. code-block:: sh

   # Ensure app-portage/flaggie and app-portage/gentoolkit are installed
   __package_emerge_dependencies


SEE ALSO
--------
* :strong:`cdist-type__package`\ (7)
* :strong:`cdist-type__package_emerge`\ (7)


AUTHORS
-------
* Thomas Oettli <otho--@--sfs.biz>


COPYING
-------
Copyright \(C) 2013 Thomas Oettli.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
