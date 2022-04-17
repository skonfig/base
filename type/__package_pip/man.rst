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


REQUIRED PARAMETERS
-------------------
None


OPTIONAL PARAMETERS
-------------------
requirement
    Can be anything supported by ``pip install`` - package name, URL, package
    with extras etc.

pip
    Instead of using pip from ``PATH``, use the specified command to execute
    pip.
    The value to this parameter can be a path, executable name or a string of
    the form ``pythonX.Y -m pip`` or ``/path/to/venv/bin/python -m pip``.

state
    Either ``present`` or ``absent``, defaults to ``present``.

runas
    Run pip as specified user. By default it runs as root.


DEPRECATED OPTIONAL PARAMETERS
------------------------------
name
    If supplied, use the name and not the object id as the package name.

extra
    Extra optional dependencies which should be installed along the selected
    package. Can be specified multiple times. Multiple extras can be passed
    in one ``--extra`` as a comma-separated list.

    Extra optional dependencies will be installed even when the base package
    is already installed. Notice that the type will not remove installed extras
    that are not explicitly named for the type because pip does not offer a
    management for orphaned packages and they may be used by other packages.



EXAMPLES
--------

.. code-block:: sh

    # Install a package
    __package_pip pyro --state present

    # Use pip in a virtualenv located at /root/shinken_virtualenv
    __package_pip pyro --state present --pip /root/shinken_virtualenv/bin/pip

    # Use pip in a virtualenv located at /foo/shinken_virtualenv as user foo
    __package_pip pyro --state present --pip /foo/shinken_virtualenv/bin/pip --runas foo

    # Install package with extras
    __package_pip mautrix-telegram --requirement mautrix-telegram[speedups,webp_convert,hq_thumbnails]

    # or take all extras
    __package_pip mautrix-telegram --requirement mautrix-telegram[all]

    # Install package from URL
    __package_pip mkosi --requirement git+https://github.com/systemd/mkosi.git


SEE ALSO
--------
:strong:`cdist-type__package`\ (7)


AUTHORS
-------
| Nico Schottelius <nico-cdist--@--schottelius.org>
| Matthias Stecher <matthiasstecher--@--gmx.de>
| Dennis Camera <cdist--@--dtnr.ch>


COPYING
-------
Copyright \(C) 2012 Nico Schottelius, 2021 Matthias Stecher, 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
