ubuntu
=========

This role constructs the base Ubuntu Docker Image for the Devops platform. It includes a standard Ubuntu distribution, plus some basic tools and SSH capabilities.
This docker Image accepts SSH connections from owner of the id_rsa.pub key
It is intended to be used as the first layer for all docker images used in the Devops platform

Requirements
------------

none

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

(c) Polymont IT Services

Author Information
------------------

- Raphael Tourneur <raphael.tourneur@polymont.fr>
- Abdallah BENBRAHIM <abdallah.benbrahim@polymont.fr>