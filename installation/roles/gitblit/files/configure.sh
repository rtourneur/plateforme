#! /bin/bash
password=$1

# Install powertools plugins
sshpass -p admin ssh admin@localhost -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null plugin install powertools

# Change admin password
sshpass -p admin ssh admin@localhost -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null gitblit users set admin password $password

# Verify plugins lists
sshpass -p $password ssh admin@localhost -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null plugin list > plugins.log
if grep -q "powertools" plugins.log; then
   rm plugins.log
 fi

#Get list of teams
sshpass -p $password ssh admin@localhost -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null gitblit teams ls > teams.log
if grep -q "developers" teams.log; then
   rm teams.log
else
  # Create developers teams
  sshpass -p $password ssh admin@localhost -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null gitblit teams new developers --canFork --canCreate > teams.log
  if grep -q "developers" teams.log; then
     rm teams.log
  else
    exit
  fi
fi

# add users to team
for i in {1..4}; do 
  sshpass -p $password ssh admin@localhost -p 29418 -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null gitblit teams members developers user$i  > teams.log
  if grep -q "user$i" teams.log; then
     rm teams.log
  else
    exit
  fi
done
