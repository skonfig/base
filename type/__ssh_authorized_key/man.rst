cdist-type__ssh_authorized_key(7)
=================================

NAME
----
cdist-type__ssh_authorized_key - Manage a single SSH authorized key entry


DESCRIPTION
-----------
Manage a single authorized key entry in an ``authorized_keys`` file.

This type was created to be used by
:strong:`cdist-type__ssh_authorized_keys`\ (7).


REQUIRED PARAMETERS
-------------------
file
   The authorized_keys file which should be managed.
key
   The SSH key which shall be managed in ``--file``.

   The value can either be:

   * a string containing the SSH public key "line", or
   * a path to a file local to the config host which contains the SSH public key.


OPTIONAL PARAMETERS
-------------------
comment
   Use this comment instead of the one which may be trailing in the key.
option
   An option to set for this authorized_key entry.
   Can be specified multiple times.
   See :strong:`sshd`\ (8) for available options.
state
   One of:

   present
      the SSH public key is authorized to connect
   absent
      the SSH public key is not authorized to connect

   Defaults to: ``present``


MESSAGES
--------
added to `file` (`entry`)
   The key `entry` (with optional comment) was added to `file`.
removed from `file` (`entry`)
   The key `entry` (with optional comment) was removed from `file`.


EXAMPLES
--------

.. code-block:: sh

   # Install an SSH public key given as a parameter
   __ssh_authorized_key some-id \
      --file /home/user/.ssh/autorized_keys \
      --key 'ssh-rsa AAAA...'

   # Install an SSH public key from a local file
   __ssh_authorized_key some-id \
      --file /home/user/.ssh/autorized_keys \
      --key "${__files:?}/ssh/id_rsa.pub" \
      --option 'command="/path/to/script"' \
      --option 'environment="FOO=bar"' \
      --comment 'one to rule them all'

   # Remove an SSH public key (from a local file)
   __ssh_authorized_key ex-employee \
      --state absent \
      --file /home/user/.ssh/autorized_keys \
      --key ~/.ssh/id_rsa.pub \


SEE ALSO
--------
* :strong:`cdist-type__ssh_authorized_keys`\ (7)
* :strong:`sshd`\ (8)


AUTHORS
-------
* Steven Armstrong <steven-cdist--@--armstrong.cc>
* Dennis Camera <dennis.camera--@--riiengineering.ch>


COPYING
-------
Copyright \(C) 2014 Steven Armstrong, 2023 Dennis Camera.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
