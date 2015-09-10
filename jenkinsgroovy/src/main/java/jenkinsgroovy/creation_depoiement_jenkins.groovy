import hudson.model.FreeStyleProject
import hudson.model.Result
import hudson.tasks.BuildTrigger
import hudson.tasks.Builder
import hudson.tasks.Shell
import jenkins.model.Jenkins


def instance = Jenkins.getInstance()

def job_deploiement = "{job}_deploiement"
def freeStyleProject = instance.createProject(FreeStyleProject.class,job_deploiement)

/*
	Exemple de script sh
	ssh sshuser@172.16.20.102 -p 2022 'ansible localhost -m file -a "dest=/home/sshuser/app01 state=directory"'
*/
def command = "/opt/script/deploiement_projet_ansible.sh -n {job}"
Builder build= new Shell(command);

/*
	Creation du lien entre le job deployment et le job maven 
	Déclenchement du build que si la construction est stable
*/
freeStyleProject.getPublishersList().add(new BuildTrigger("{job}", Result.SUCCESS))

//ajout du script shell
freeStyleProject.getBuildersList().add(build)

command.execute()
instance.save();