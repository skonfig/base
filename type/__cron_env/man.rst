cdist-type__cron_env(7)
=======================

NAME
----
cdist-type__cron_env - Manage crontab environment variable settings


DESCRIPTION
-----------
Some implementations of the cron daemon support specifying some
environment variables in the crontab to control the execution of cron jobs.

This type can manage these environment variables. It will not, however, check if
the crond running on the target supports environment variables.

This type will try to keep the position of variables when modifying their value.
It will try to insert new variable definitions prior to the first cron job
definition.

Some cron daemons (e.g. on Solaris) support redefining environment variables to
set different values for different cron jobs.
Controlling the position at which the variable definitions will be inserted is
not supported by this type.


REQUIRED PARAMETERS
-------------------
user
   The user whose crontab should be edited.


OPTIONAL PARAMETERS
-------------------
name
   The name of the variable to configure.

   Defaults to: ``__object_id``
state
   One of:

   ``present``
      the variable should be set to the given value
   ``absent``
      the variable should be removed
value
   The value of the variable.

   Required if ``--state present``.


EXAMPLES
--------

.. code-block:: sh

   # Set the shell for user bob to bash
   __cron_env SHELL --user bob --value /bin/bash

   # Notify root if backup jobs produce output
   __cron_env MAILTO --user backup --value root


SEE ALSO
--------
* :strong:`cdist-type__cron`\ (7)
* :strong:`crontab`\ (5)


AUTHORS
-------
* Dennis Camera <skonfig--@--dtnr.ch>


COPYING
-------
Copyright \(C) 2022 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
