cdist-type__package_pkgsrc(7)
=============================

NAME
----
cdist-type__package_pkgsrc - Manage packages using the pkgsrc package manager.


DESCRIPTION
-----------
This type can be used to manage packages using the pkgsrc package
manager. It is the default package manager on NetBSD and SmartOS, but
is installable on other operating systems, like Illomos or Mac OS X,
as well.

Please note that this type uses the underlying :strong:`pkg_install`
commands (:strong:`pkg_add`\ (1), :strong:`pkg_info`\ (1),
:strong:`pkg_delete`\ (1) & co.) over the more "convenient"
:strong:`pkgin`\ (1), because they are always available while
:strong:`pkgin`\ (1) has to be installed manually and it is only a
wrapper for :strong:`pkg_install` anyway.

This means that special :strong:`pkgin`\ (1) configuration
(e.g. ``repositories.conf``) will not be respected by this type.


OPTIONAL PARAMETERS
-------------------
name
   The name of the package to install.

   Defaults to: ``__object_id``
version
   If supplied, use to avoid ambiguity.

   This can be a version number only (to mean exactly this version) or
   any other package wildcard supported by :strong:`pkg_info`\ (1), e.g.
   ``>=3.0``, ``>=3.0<4``.
pkg-path
   Manually specify a ``PKG_PATH`` to add packages from.

   When not specified, the system default from :strong:`pkg_install.conf`\ (5)
   or a global evironment variable will be used.
state
   One of:

   ``present``
      the package is installed
   ``absent``
      | the package is not installed
      | Automatically installed packages which are no longer required will be
        removed as well.


EXAMPLES
--------

.. code-block:: sh

   # Install the htop package
   __package_pkgsrc htop

   # Install GNU bash 2.05 (if you need such an old version for whatever reason)
   __package_pkgsrc bash --version '>=2.0<3'


SEE ALSO
--------
* :strong:`cdist-type__package`\ (7)
* :strong:`pkg_add`\ (1)
* https://pkgsrc.org/


AUTHORS
-------
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2025 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
