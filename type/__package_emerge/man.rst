cdist-type__package_emerge(7)
=============================

NAME
----
cdist-type__package_emerge - Manage packages with portage


DESCRIPTION
-----------
Portage is usually used on the gentoo distribution to manage packages.
This type requires app-portage/gentoolkit installed on the target host.
cdist-type__package_emerge_dependencies is supposed to install the needed
packages on the target host.


OPTIONAL PARAMETERS
-------------------
name
   The name of the package to install.

   Defaults to: ``__object_id``
state
   One of:

   present
      the package is installed
   absent
      the package is uninstalled

   Defaults to: ``present``
version
   If supplied, use to install or uninstall a specific version of the package
   named.


EXAMPLES
--------

.. code-block:: sh

   # Ensure sys-devel/gcc is installed
   __package_emerge sys-devel/gcc --state present

   # If you want a specific version of a package
   __package_emerge app-portage/gentoolkit --state present --version 0.3.0.8-r2

   # Remove package
   __package_emerge sys-devel/gcc --state absent


SEE ALSO
--------
* :strong:`cdist-type__package`\ (7)
* :strong:`cdist-type__package_emerge_dependencies`\ (7)


AUTHORS
-------
* Thomas Oettli <otho--@--sfs.biz>


COPYING
-------
Copyright \(C) 2013 Thomas Oettli.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
