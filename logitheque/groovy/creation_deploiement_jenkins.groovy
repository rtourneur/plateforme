import hudson.model.FreeStyleProject
import hudson.model.Result
import hudson.tasks.BuildTrigger
import hudson.tasks.Builder
import hudson.tasks.Shell
import jenkins.model.Jenkins


def instance = Jenkins.getInstance()

def job_ = "{job}"
def depl_ = "_deploiement"
def job_deploiement = "$job_$depl_"
def freeStyleProject = instance.createProject(FreeStyleProject.class,job_deploiement)

def command = "/opt/scripts/deploiement_projet_ansible.sh -a $job_"
Builder build= new Shell(command);

/*
 * Creation du lien entre le job deployment et le job maven
 * Déclenchement du build que si la construction est stable
*/
freeStyleProject.getPublishersList().add(new BuildTrigger(job_, Result.SUCCESS))

/*
 * Appel du script shell
 */
freeStyleProject.getBuildersList().add(build)

instance.save();