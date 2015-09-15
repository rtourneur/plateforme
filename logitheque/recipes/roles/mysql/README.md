Role Name
=========

This role manages tasks for mysql infrastructure component.

The component descriptor (Ansible playbook) for this component can define variables as in the example below :

image: "mysql:5.6.26"
ports:
  mysql:
    host: "10306"
    container: "3306"
database:
  password: "root"
  erase_data_directory: "false"
  max_startup_time: "30"
  path: "src/database"
  scripts:
  - "create_db_formation.sql"
  - "create_table_catalogue_formation.sql"

database.password defines the Mysql root user password.
database.erase_data_directory: when set to "true", the entire Mysql data directory is erased. All data is lost.
database.max_startup_time defines the time interval to wait after the startup of the container and the first command sent to it. Allows the database server to initialize.
database.path definies the directory (form the working copy of the project directory) for the initialization scripts (see below)
database.scripts is a (possibly void) list of Sql initialization scripts to run on the database. It is executed as Mysql root user (to allow for database creation).

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
