cdist-type__apt_pin(7)
======================

NAME
----
cdist-type__apt_pin - Manage APT pinning rules


DESCRIPTION
-----------
Manage the priorities of APT packages based on the package version,
the repository they come from, or the repository server.
This is commonly called "pinning".

When packages are contained in multiple repositories, pinning becomes useful to
specify which sources APT should install packages from (e.g. backports or
vendor repositories).


OPTIONAL PARAMETERS
-------------------
description
   A description to be added as a comment to the pin configuration.

   Defaults to: ``__object_id``
distribution
   Specifies what distribution the package should be pinned to.

   Accepts both codenames (e.g. ``buster``, ``bullseye``, ``sid``) and
   suite names (``stable``, ``oldstable``, ``testing``, ...).

   **NB:** This parameter is kept for backwards compatibility.
   It is better to use ``--release`` instead, as it is more flexible and does
   not rely on this type differentiating archive and code names correctly.

   If ``--origin``, ``--release``, or ``--version`` is used, this parameter will
   be silently ignored.
origin
   Pin ``--package`` to the specified origin (=hostname).

   The value will be automatically quoted.
   An empty value means "the local site".

   Do not confuse ``--origin`` with the ``Origin`` of a distribution as
   specified in a repository Release file.

   This parameter is mutually exclusive with ``--release`` and ``--version``.
package
   The package(s) this pin applies to.

   Can be a
   * package name,
   * glob,
   * regular expression (ERE) (wrapped in `/.../`), or
   * a source package name (`src:...`).

   For more details cf. :strong:`apt_preferences`\ (5).

   Can be used multiple times to specify multiple packages for this pin.

   Defaults to: ``__object_id``
priority
   The priority value to assign to matching packages.

   Defaults to: 500 (to match the default target release's priority)
release
   Pin ``--package`` to the specified release.

   The release can filter distributions by various Release properties,
   cf. :strong:`apt_preferences`\ (5) for more details.

   This parameter is mutually exclusive with ``--origin`` and ``--version``.
state
   Will be passed to the underlying :strong:`cdist-type__file`\ (7) object.

   Can be any value `__file --state`` accepts.

   Defaults to: ``present``
version
   Pin ``--package`` to the specified package version.

   This parameter is mutually exclusive with ``--origin`` and ``--release``.


EXAMPLES
--------

.. code-block:: sh

   # Add the bullseye repo to buster, but do not install any packages by default
   # only if explicitly asked for (-1 means "never")
   __apt_pin bullseye-default \
      --package '*' \
      --release 'n=bullseye' \
      --priority -1
   require=__apt_pin/bullseye-default \
   __apt_source bullseye \
      --uri 'http://deb.debian.org/debian/' \
      --release 'n=bullseye' \
      --component main

   # install foo from bullseye distribution
   __apt_pin foo \
      --package 'foo foo-*' \
      --release 'n=bullseye'
   require=__apt_pin/foo \
   __package foo

   # enforce ejabberd version 23.01
   __apt_pin ejabberd \
      --package 'src:ejabberd' \
      --version '23.01*' \
      --priority 1000

   # prefer packages from example.com repository
   __apt_pin ownrepo \
      --package '**' \
      --origin 'deb.example.com' \
      --priority 600


SEE ALSO
--------
* :strong:`apt_preferences`\ (5)
* :strong:`cdist-type__apt_source`\ (7)
* :strong:`cdist-type__apt_backports`\ (7)
* :strong:`cdist-type__file`\ (7)


AUTHORS
-------
* Daniel Fancsali <fancsali--@--gmail.com>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2021 Daniel Fancsali, 2024 Dennis Caemra.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
