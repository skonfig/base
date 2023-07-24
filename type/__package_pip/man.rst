cdist-type__package_pip(7)
==========================

NAME
----
cdist-type__package_pip - Manage packages with pip


DESCRIPTION
-----------
Pip is used in Python environments to install packages.
It is also included in the Python virtualenv environment.

**NB:** This type requires that pip is already installed on the target host.
Since pip is tightly coupled to a specific Python interpreter and it is common
to have multiple interpreters (e.g. CPython 2.x, 3.x and/or PyPy) and
venvs (virtual environments) installed at the same time, this type does not try
to guess which pip to use.
Most OSes provide a package to get a default pip installation, so it's usually
sufficient to add ``__package python3-pip`` to your manifest.

On Debian-derived systems you may need to install setuptools
(``__package python3-setuptools``) for pip to work correctly, as well.


OPTIONAL PARAMETERS
-------------------
pip
   Instead of using pip from ``PATH``, use the specified command to execute
   pip.
   The value to this parameter can be either
   * an absolute path to a pip executable,
   * a command name, or
   * a string of the form ``pythonX.Y -m pip`` / ``/path/to/venv/bin/python -m pip``.
requirement
   Can be anything supported by ``pip install`` - package name, URL, package
   with extras etc.

   Defaults to: ``__object_id``
runas
   Run pip as specified user. By default it runs as root.
state
   One of:

   ``present``
      the package is installed
   ``absent``
      the package is uninstalled

   Defaults to: ``present``


EXAMPLES
--------

.. code-block:: sh

   # Install a package
   __package_pip supervisor

   # Install a package using a specific version of pip
   __package_pip Sphinx \
      --pip pip3.11

   # Use pip in a virtualenv located at /root/shinken_virtualenv
   __package_pip pyro \
      --pip /root/shinken_virtualenv/bin/pip

   # Use pip in a virtualenv located at /foo/shinken_virtualenv as user foo
   __package_pip pyro \
      --pip /foo/shinken_virtualenv/bin/pip --runas foo

   # Install package with extras
   __package_pip mautrix-telegram \
      --requirement mautrix-telegram[speedups,webp_convert,hq_thumbnails]

   # or take all extras
   __package_pip mautrix-telegram \
      --requirement mautrix-telegram[all]

   # Install package from URL
   __package_pip mkosi \
      --requirement git+https://github.com/systemd/mkosi.git

   # Uninstall a package :-)
   __package_pip cdist --state absent


SEE ALSO
--------
* :strong:`cdist-type__package`\ (7)


AUTHORS
-------
* Nico Schottelius <nico-cdist--@--schottelius.org>
* Matthias Stecher <matthiasstecher--@--gmx.de>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2012 Nico Schottelius, 2021 Matthias Stecher, 2022-2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
