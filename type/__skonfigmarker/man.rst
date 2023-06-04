cdist-type__skonfigmarker(7)
============================

NAME
----
cdist-type__skonfigmarker - Set the "skonfigured" marker.


DESCRIPTION
-----------
This type creates or updates a marker file every time it is run. The destination
of the marker file can be specified using the ``--destination`` parameter.
The marker file contains a timestamp which can be used to determine the last
time :strong:`skonfig`\ (1) was run on this target.


OPTIONAL PARAMETERS
-------------------
destination
   The pathname of the marker to be created.

   Defaults to: ``/etc/skonfigured``
format
   The format of the timestamp which will be stored in ``--destination``.
   The value can be any format specifier supported by :strong:`date`\ (1)
   without the leading ``+``.

   The timestamp uses the UTC timezone.

   The default is the output of ``date``.


EXAMPLES
--------

.. code-block:: sh

   # Create a default marker
   __skonfigmarker

   # Create a marker file containing the date in ISO 8601 format.
   __skonfigmarker --format '%Y-%m-%dT%H:%M:%SZ'

   # Create a marker file in a different location and containing the timestamp
   # in UNIX epoch format
   __skonfigmarker --destination /tmp/mymarker --format '%s'


SEE ALSO
--------
* :strong:`cdist-type__cdistmarker`\ (7)


AUTHORS
-------
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
| Copyright \(C) 2023 Dennis Camera.
| This type is inspired by the original :strong:`cdist-type__cdistmarker`\ (7):
  Copyright \(C) 2011 Daniel Maher <phrawzty+cdist--@--gmail.com>.
| You can redistribute it and/or modify it under the terms of the GNU General
  Public License as published by the Free Software Foundation, either version 3
  of the License, or (at your option) any later version.
