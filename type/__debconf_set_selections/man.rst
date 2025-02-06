cdist-type__debconf_set_selections(7)
=====================================

NAME
----
cdist-type__debconf_set_selections - Setup debconf selections


DESCRIPTION
-----------
On Debian and alike systems :strong:`debconf-set-selections`\ (1) can be used
to setup configuration parameters.


OPTIONAL PARAMETERS
-------------------
file
   Use the given filename as input for :strong:`debconf-set-selections`\ (1)
   If filename is ``-``, read from stdin.

   **This parameter is deprecated, because it doesn't work with state
   detection.**
line
   A line in :strong:`debconf-set-selections`\ (1) compatible format.
   This parameter can be used multiple times to set multiple options.

   (This parameter is actually required, but marked optional because the
   deprecated ``--file`` is still accepted.)
onchange
   Run command after change. Runs after ``--reconfigure``.


BOOLEAN PARAMETERS
------------------
reconfigure
   Run ``dpkg-reconfigure <package>`` after change. Runs before ``--onchange``.
   Package name is parsed from ``--line``.


EXAMPLES
--------

.. code-block:: sh

   # Setup gitolite's gituser
   __debconf_set_selections nslcd \
      --line 'gitolite gitolite/gituser string git'

   # Setup configuration for nslcd from a file.
   # NB: Multiple lines can be passed to --line, although this can be considered
   #     a hack.
   __debconf_set_selections nslcd \
      --line "$(cat "${__files:?}/preseed/nslcd.debconf")"

   # Reconfigure wireshark-common package
   require=__package_apt/wireshark \
   __debconf_set_selections wireshark \
      --line 'wireshark-common wireshark-common/install-setuid boolean true' \
      --reconfigure


SEE ALSO
--------
* :strong:`cdist-type__update_alternatives`\ (7)
* :strong:`debconf-set-selections`\ (1)


AUTHORS
-------
* Nico Schottelius <nico-cdist--@--schottelius.org>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2011-2014 Nico Schottelius, 2021 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
