cdist-type__cron(7)
===================

NAME
----
cdist-type__cron - Installs and manages cron jobs


DESCRIPTION
-----------
This cdist type allows you to manage entries in a user's crontab.


REQUIRED PARAMETERS
-------------------
user
   The user whose crontab is edited.
command
   The command to run.

   Please note that cron implementations adhering to the POSIX specification
   will treat all ``%`` (percent) signs in the command as ``<newline>``
   characters.
   This type will not do any % replacements. The command given will be passed
   literally into the crontab file.


OPTIONAL PARAMETERS
-------------------
**NOTE**: All time-related parameters (``--minute``, ``--hour``,
``--day-of-month``, ``--month`` and ``--day-of-week``) default to ``*``
which means to execute it **always**.
If you set ``--hour 0`` to execute the cronjob only at midnight, it
will execute **every** minute in the first hour of the morning every day.

state
   Either present or absent. Defaults to present.
minute
   See crontab(5). Defaults to *
hour
   See crontab(5). Defaults to *
day-of-month
   See crontab(5). Defaults to *
month
   See crontab(5). Defaults to *
day-of-week
   See crontab(5). Defaults to *
raw
   Take whatever the user has given instead of time and date fields.
   If given, all other time and date fields are ignored.
   Can for example be used to specify cron EXTENSIONS like ``@reboot``,
   ``@yearly``, etc.
   See :strong:`crontab`\ (5) for the extensions if any that your cron
   implementation implements.


EXAMPLES
--------

.. code-block:: sh

    # run Monday to Saturday at 23:15
    __cron some-id --user root --command "/path/to/script" \
       --hour 23 --minute 15 --day-of-week 1-6

    # run on reboot
    __cron some-id --user root --command "/path/to/script" \
       --raw @reboot

    # remove cronjob
    __cron some-id --user root --command "/path/to/script" --state absent


SEE ALSO
--------
* :strong:`crontab`\ (5)
* :strong:`cdist-type__cron_env`\ (7)


AUTHORS
-------
| Steven Armstrong <steven-cdist--@--armstrong.cc>
| Dennis Camera <cdist--@--dtnr.ch>


COPYING
-------
Copyright \(C) 2011-2013 Steven Armstrong, 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
