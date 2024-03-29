cdist-type__locale_system(7)
============================

NAME
----
cdist-type__locale_system - Set system-wide locale


DESCRIPTION
-----------
This type allows you to modify system-wide locale.
The name of the locale category is given as the ``__object_id``
(usually you are probably interested in using ``LANG``).


OPTIONAL PARAMETERS
-------------------
state
   One of:

   ``present``
      set the locale category to the given value
   ``absent``
      remove the locale category from the system file

   Defaults to: ``present``
value
   The value for the locale category.

   Defaults to: ``C``


EXAMPLES
--------

.. code-block:: sh

   # Set LANG to en_US.UTF-8
   __locale_system LANG

   # Same as above, but more explicit
   __locale_system LANG --value en_US.UTF-8

   # Set category LC_MESSAGES to de_CH.UTF-8
   __locale_system LC_MESSAGES --value de_CH.UTF-8

   # Remove setting for LC_ALL
   __locale_system LC_ALL --state absent


SEE ALSO
--------
* :strong:`locale`\ (1)
* :strong:`localedef`\ (1)
* :strong:`cdist-type__locale`\ (7)


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>
* Carlos Ortigoza <carlos.ortigoza--@--ungleich.ch>
* Nico Schottelius <nico.schottelius--@--ungleich.ch>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2012-2016 Steven Armstrong;
2016 Carlos Ortigoza, Nico Schottelius;
2020-2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
