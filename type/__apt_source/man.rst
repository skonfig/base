cdist-type__apt_source(7)
=========================

NAME
----
cdist-type__apt_source - Manage APT sources


DESCRIPTION
-----------
This type allows you to manage APT sources. It invokes index update internally
when needed so call of index updating type is not needed.


REQUIRED PARAMETERS
-------------------
uri
   The URI to the APT repository.


OPTIONAL MULTIPLE PARAMETERS
----------------------------
signed-by
   Provide a GPG key fingerprint or keyring path for signature checks.


OPTIONAL PARAMETERS
-------------------
arch
   Set this if you need to force any specific CPU architectures.
   This parameter can be used multiple times.

   Defaults to download all architectures defined by ``APT::Architectures``.
component
   The component(s) to enable. Can be used multiple times.
distribution
   The distribution codename to use.

   Defaults to: auto-detected release codename of the target.
state
   ``present`` or ``absent``

   Defaults to: ``present``


BOOLEAN PARAMETERS
------------------
include-src
   Add ``deb-src`` entries.


EXAMPLES
--------

.. code-block:: sh

   __apt_source rabbitmq \
      --state present \
      --uri http://www.rabbitmq.com/debian/ \
      --distribution testing \
      --component main \
      --include-src

   __apt_source canonical_partner \
      --state present \
      --uri http://archive.canonical.com/ \
      --component partner

   __apt_source goaccess \
      --uri http://deb.goaccess.io/ \
      --component main \
      --signed-by C03B48887D5E56B046715D3297BD1A0133449C3D


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>
* Daniel Fancsali <fancsali--@--gmail.com>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2011-2018 Steven Armstrong, 2022 Daniel Fancsali,
2022,2025 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
