cdist-type__timezone(7)
=======================

NAME
----
cdist-type__timezone - Configure the system timezone.


DESCRIPTION
-----------
This type creates a symlink (``/etc/localtime``) to the selected
timezone (which should be available in ``--tzdir`` which is usually
``/usr/share/zoneinfo``).

On some operating systems, other system-specific files are modified as well.

If necessary, the zoneinfo database (``tzdata``) will be installed on the target.


REQUIRED PARAMETERS
-------------------
tz
   The name of the timezone to set.

   It should map to a file present in ``--tzdir``.


OPTIONAL PARAMETERS
-------------------
tzdir
   The directory containing the timezone data files on the target.

   Default: detected based on OS, usually ``/usr/share/zoneinfo``.


EXAMPLES
--------

.. code-block:: sh

   # Set up Europe/Andorra as our timezone.
   __timezone --tz Europe/Andorra

   # Set up US/Central as our timezone.
   __timezone --tz US/Central

   # Some operating systems (e.g. Debian, RedHat, SuSE) have a separate
   # directory for POSIX timezones (time values interpreted as seconds since
   # the epoch, not counting leap seconds).
   # It can be used by manually specifying the TZDIR.
   __timezone --tz Europe/Vaduz --tzdir /usr/share/zoneinfo/posix


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>
* Nico Schottelius <nico-cdist--@--schottelius.org>
* Ramon Salvadó <rsalvado--@--gnuine.com>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2012-2025 the `AUTHORS`_.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
