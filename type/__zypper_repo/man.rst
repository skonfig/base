cdist-type__zypper_repo(7)
==========================

NAME
----
cdist-type__zypper_repo - Repository management with zypper


DESCRIPTION
-----------
zypper is usually used on the SuSE distribution to manage repositories.


OPTIONAL PARAMETERS
-------------------
repo_desc
   If supplied, use the description and not the object id as repo description,
   only used if ``--state present`` and the repo has to be created
repo_id
   the repo id to use.
   Can be used with state absent, enabled and disabled.

   Defaults to: ``__object_id``
state
   One of:

   present
      make sure that the repo is available, needs uri and repo_desc for all
      following states, the repo can be searched via repo_id or uri
   absent
      drop the repo if found
   enabled
      a repo can have state disabled if installed via zypper service (ris), in
      this case, you can enable the repo
   disabled
      instead of absent (drop), a repo can also set to disabled, which makes it
       inaccessible

   Defaults to: ``present``
uri
   If supplied, use the uri and not the object id as repo uri.


EXAMPLES
--------

.. code-block:: sh

   # Ensure testrepo in installed
   __zypper_repo testrepo \
      --state present \
      --uri http://url.to.your.repo/with/path

   # Drop repo by repo uri
   __zypper_repo testrepo \
      --state absent --uri http://url.to.your.repo/with/path

   # Drop repo by id number (attention: repos are always numbered from 1 to max)
   __zypper_repo testrepo \
      --state absent --repo_id 1

   # enable repo by id
   __zypper_repo testrepo2 \
      --state enabled --repo_id 2

   # enable repo by uri
   __zypper_repo testrepo3 \
      --state enabled --uri http://url.to.your.repo/with/path

   # disable a repo works like enabling it
   __zypper_repo testrepo4 \
      --state disabled --repo_id 4


AUTHORS
-------
* Daniel Heule <hda--@--sfs.biz>


COPYING
-------
Copyright \(C) 2013 Daniel Heule.
You can redistribute it and/or modify it under the terms of the GNU General
Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.
