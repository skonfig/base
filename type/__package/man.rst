cdist-type__package(7)
======================

NAME
----
cdist-type__package - Manage packages


DESCRIPTION
-----------
This cdist type allows you to install or uninstall packages on the target.
It dispatches the actual work to the package system dependent types.


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
type
   The package manager to use.

   The default is determined based on the target operating system.
   e.g.
   * :strong:`cdist-type__package_apt`\ (7) for Debian,
   * :strong:`cdist-type__package_emerge`\ (7) for Gentoo.
version
   The version of the package to install.

   Default is to install the version chosen by the local package manager.


EXAMPLES
--------

.. code-block:: sh

   # Install the package vim on the target
   __package vim --state present

   # Same but install specific version
   __package vim --state present --version 7.3.50

   # Force use of a specific package type
   __package vim --state present --type __package_apt


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>


COPYING
-------
Copyright \(C) 2011 Steven Armstrong.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
