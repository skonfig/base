cdist-type__localedef(7)
========================

NAME
----
cdist-type__localedef - Define and remove system locales


DESCRIPTION
-----------
This cdist type allows you to define locales on the system using
:strong:`localedef`\ (1) or remove them.
On systems that don't support definition of new locales, the type will raise an
error (cf. ``getconf POSIX2_LOCALEDEF``).

**NB:** This type respects the glibc ``locale.alias`` file,
i.e. it defines alias locales or deletes aliases of a locale when it is removed.
It is not possible, however, to use alias names to define locales or only remove
certain aliases of a locale.


OPTIONAL PARAMETERS
-------------------
state
   One of:

   ``present``
      the locale is defined.
   ``absent``
      the locale is not defined/removed.

   Defaults to: ``present``


EXAMPLES
--------

.. code-block:: sh

   # Add locale de_CH.UTF-8
   __localedef de_CH.UTF-8

   # Same as above, but more explicit
   __localedef de_CH.UTF-8 --state present

   # Remove colourful British English
   __localedef en_GB.UTF-8 --state absent


SEE ALSO
--------
* :strong:`locale`\ (1)
* :strong:`localedef`\ (1)
* :strong:`cdist-type__locale_system`\ (7)


AUTHORS
-------
* Dennis Camera <dennis.camera--@--riiengineering.ch>
* Nico Schottelius <nico-cdist--@--schottelius.org>


COPYING
-------
Copyright \(C) 2013-2019 Nico Schottelius; 2020,2023,2025 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
