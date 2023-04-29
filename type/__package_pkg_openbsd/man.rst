cdist-type__package_pkg_openbsd(7)
==================================

NAME
----
cdist-type__package_pkg_openbsd - Manage OpenBSD packages


DESCRIPTION
-----------
This type is usually used on OpenBSD to manage packages.


OPTIONAL PARAMETERS
-------------------
flavor
   If supplied, use to avoid ambiguity.
name
   The name of the package to install.

   Defaults to: ``__object_id``
pkg_path
   Manually specify a PKG_PATH to add packages from.
state
   One of:

   present
      the package is installed
   absent
      the package is uninstalled

   Defaults to: ``present``
version
   If supplied, use to avoid ambiguity.


EXAMPLES
--------

.. code-block:: sh

   # Ensure zsh is installed
   __package_pkg_openbsd zsh --state present

   # Ensure vim is installed, use flavor no_x11
   __package_pkg_openbsd vim --state present --flavor no_x11

   # If you don't want to follow pythonX packages, but always use python
   __package_pkg_openbsd python --state present --name python2

   # Remove obsolete package
   __package_pkg_openbsd puppet --state absent

   # Add a package using a particular mirror
   __package_pkg_openbsd bash \
     --pkg_path http://openbsd.mirrorcatalogs.com/snapshots/packages/amd64


SEE ALSO
--------
* :strong:`cdist-type__package`\ (7)


AUTHORS
-------
* Andi Brönnimann <andi-cdist--@--v-net.ch>


COPYING
-------
Copyright \(C) 2011 Andi Brönnimann.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
