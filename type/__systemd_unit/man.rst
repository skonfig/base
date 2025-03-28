cdist-type__systemd_unit(7)
===========================

NAME
----
cdist-type__systemd_unit - Install a systemd unit


DESCRIPTION
-----------
This type manages systemd units in ``/etc/systemd/system/``. It can install,
enable and start a systemd unit. This is particularly useful on systems which
take advantage of systemd heavily (e.g., CoreOS). For more information about
systemd units, see SYSTEMD.UNIT(5).


OPTIONAL PARAMETERS
-------------------
drop-in
   Create drop-in file for existing unit.
enablement-state
   'enabled', 'disabled' or 'masked', where:

   enabled
      enables the unit
   disabled
      disables the unit
   masked
      masks the unit
source
   Path to the config file. If source is '-' (dash), take what was written to
   stdin as the config file content.
state
   'present' or 'absent', defaults to 'present' where:

   present
      the unit (or its mask) is installed
   absent
      The unit is stopped, disabled and uninstalled. If the unit was masked,
      the mask is removed.


BOOLEAN PARAMETERS
------------------
restart
   Start the unit if it was inactive. Restart the unit if the unit file
   changed. Stop the unit if new ``enablement-state`` is ``masked``.


MESSAGES
--------
enabled
   Unit was enabled.
disabled
   Unit was disabled.
masked
   Unit was masked.
removed
   Unit was stopped, disabled and removed.


EXAMPLES
--------

.. code-block:: sh

   # Installs, enables and starts foobar.service
   __systemd_unit foobar.service \
       --source "${__manifest}/files/foobar.service" \
       --enablement-state enabled \
       --restart

   # Disables the unit
   __systemd_unit foobar.service --enablement-state disabled

   # Stops, disables and uninstalls foobar.service
   __systemd_unit foobar.service --state absent

   # Use messaging to restart service if configuration is changed or service is enabled
   __file /etc/nginx/nginx.conf \
       --source "$__files/nginx.conf"

   require='__file/etc/nginx/nginx.conf' \
       __systemd_unit nginx.service \
           --enablement-state enabled

   require='__systemd_unit/nginx.service' \
       __check_messages nginx \
           --pattern '(nginx\.conf|nginx\.service:enabled)' \
           --execute 'systemctl restart nginx.service'


AUTHORS
-------
* Ľubomír Kučera <lubomir.kucera.jr--@--gmail.com>
* Ander Punnar <ander--@--kvlt.ee>


COPYING
-------
Copyright \(C) 2017 Ľubomír Kučera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
