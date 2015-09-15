tomcat component
=========

This role manages tasks for tomcat infrastructure component.
Most work is done by this role, but the final deployment is managed by the Tomcat_application_deployer role (this chain is managed by the tomcat playbook)

The component descriptor (Ansible playbook) for this component can define variables as in the example below :

image: "polymont/tomcat:8"
ports:
  tomcat:
    host: "10080"
    container: "8080"
  ssh:
    host: "10022"
    container: "22"
link:
  container: "mysql"
  alias: "formation" 
appserver:
  path: "formation-tp3-web/target"
  war: "formation-tp3-web-0.0.1-SNAPSHOT.war"

appserver.path defines the path of the war file in the project (target of the build)
appserver.war defines the name of the war file


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
- Christophe SCARFOGLIERE <c.scarfogliere@polymont.fr>