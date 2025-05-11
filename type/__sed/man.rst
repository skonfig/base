cdist-type__sed(7)
==================

NAME
----
cdist-type__sed - Transform text files with :strong:`sed`\ (1)


DESCRIPTION
-----------
Transform text files with :strong:`sed`\ (1).


REQUIRED MULTIPLE PARAMETERS
----------------------------
script
   ``sed`` script.
   If ``-`` then the script is read from ``stdin``.


OPTIONAL PARAMETERS
-------------------
file
   Path to the file.

   Defaults to: ``$__object_id``
onchange
   Execute the given command after :strong:`sed`\ (1) changed the file.

   Can be used multiple times to execute multiple commands.
   The commands will be executed in the order the parameters are specified.


BOOLEAN PARAMETERS
------------------
regexp-extended
   Use extended regular expressions in the script.
   Might not be supported with every ``sed`` version.


EXAMPLES
--------

.. code-block:: sh

   __sed /tmp/foobar --script 's/foo/bar/'

   echo 's/foo/bar/' | __sed foobar --file /tmp/foobar --script -


AUTHORS
-------
* Ander Punnar <ander--@--kvlt.ee>


COPYING
-------
Copyright \(C) 2021 Ander Punnar.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
