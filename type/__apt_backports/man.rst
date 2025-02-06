cdist-type__apt_backports(7)
============================

NAME
----
cdist-type__apt_backports - Configure the backports APT repository


DESCRIPTION
-----------
This singleton type manages the backports repository for the current OS
release and updates the package index if required.

It supports backports for the following OSes:

* Debian
* Devuan
* Ubuntu

**NB:** The type aborts if no distribuition codename could be detected. This is
common for unstable releases, but there is no backports repository for these
anyway.


OPTIONAL PARAMETERS
-------------------
component
   The components to use for the backports repository.

   Can be used multiple times to specify more than one component.

   Defaults to: ``main``
mirror
   The mirror to fetch the backports from.

   Defaults to the generic mirror of the current OS.
state
   The should state of the backports repository. ``present`` or
   ``absent``.

   Defaults to: ``present``


EXAMPLES
--------

.. code-block:: sh

   # setup the backports
   __apt_backports
   __apt_backports --state absent
   __apt_backports --state present --mirror "http://ftp.de.debian.org/debian/"

   # install a backports package
   # currently for the buster release backports
   require="__apt_backports" __package_apt wireguard \
        --target-release buster-backports


SEE ALSO
--------
* `Official Debian Backports site <https://backports.debian.org/>`_
* :strong:`cdist-type__apt_source`\ (7)


AUTHORS
-------
* Matthias Stecher <matthiasstecher--@--gmx.de>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2020 Matthias Stecher, 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
