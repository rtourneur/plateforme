import hudson.model.FreeStyleProject
import hudson.model.Result
import hudson.tasks.Builder
import hudson.tasks.Shell
import jenkins.model.Jenkins
import jenkins.triggers.ReverseBuildTrigger


def instance = Jenkins.getInstance()

def job_ = "{job}"
def depl_ = "_deploiement"
def job_deploiement = "$job_$depl_"
def freeStyleProject = instance.createProject(FreeStyleProject.class,job_deploiement)

def command = "/opt/scripts/deploiement_projet_ansible.sh -a $job_ -e dev"
Builder build= new Shell(command);

/*
 * Creation du lien entre le job deployment et le job maven
 * Déclenchement du build que si la construction est stable
*/
ReverseBuildTrigger trigger = new ReverseBuildTrigger(job_, Result.SUCCESS);
freeStyleProject.addTrigger(trigger)
trigger.start(freeStyleProject, true)

/*
 * Appel du script shell
 */
freeStyleProject.getBuildersList().add(build)

instance.save();