cdist-type__package_pip(7)
==========================

NAME
----
cdist-type__package_pip - Manage packages with pip


DESCRIPTION
-----------
Pip is used in Python environments to install packages.
It is also included in the python virtualenv environment.


REQUIRED PARAMETERS
-------------------
None


OPTIONAL PARAMETERS
-------------------
requirement
    Can be anything supported by `pip install` - package name, URL, package
    with extras etc. If this is anything else than package name (e.g. URL),
    then object id must be package name, otherwise state explorer will fail and
    type will be not idempotent.

pip
    Instead of using pip from PATH, use the specific pip path.

state
    Either "present" or "absent", defaults to "present"

runas
    Run pip as specified user. By default it runs as root.


DEPRECATED OPTIONAL PARAMETERS
------------------------------
name
    If supplied, use the name and not the object id as the package name.

extra
    Extra optional dependencies which should be installed along the selected
    package. Can be specified multiple times. Multiple extras can be passed
    in one `--extra` as a comma-separated list.

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


COPYING
-------
Copyright \(C) 2012 Nico Schottelius, 2021 Matthias Stecher. You can
redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either
version 3 of the License, or (at your option) any later version.
