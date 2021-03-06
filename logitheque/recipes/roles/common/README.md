Common component
=========

This role is the base role for components of the 'logitheque'.
It provides common (if not universal) utilities :
- opening of communication ports in CentOS firewall

All components are driven by component descriptors, provided as Ansible playbooks defining variables.
These variables are directives used to conduct the configuration of the component.

At least, the component descriptor will define the name of the docker image to use :
image: "mysql:5.6.26"

The component descriptor may also contain the definition of a docker link 
link:
  container: "targetContainerName"
  alias: "linkName"
  
The component descriptor may also contain the definition of ports mapping for the container
ports:
  myportname:
    host: "10306"
    container: "3306"    

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

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

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
