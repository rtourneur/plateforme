import hudson.maven.MavenModuleSet
import hudson.model.JDK
import jenkins.model.Jenkins

import com.cloudbees.plugins.credentials.CredentialsScope
import com.cloudbees.plugins.credentials.SystemCredentialsProvider
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl


def instance = Jenkins.getInstance()
// Create new Maven job
MavenModuleSet mavenModuleSet = instance.createProject(MavenModuleSet.class,"{job}");
mavenModuleSet.setRunHeadless( true );

// Set jdk version in job
def jdk = new JDK("{jdk}",null)
mavenModuleSet.setJDK(jdk)

// Set maven version and options in job
mavenModuleSet.setMaven("{maven}")
mavenModuleSet.setRootPOM("pom.xml")
mavenModuleSet.setGoals("{goals}")

// Retrieve global credentials
global_domain = Domain.global()
credentials_store = SystemCredentialsProvider.getInstance().getStore();

list = credentials_store.getCredentials(global_domain)

// Search admin credentials
def credentials=null 
for (item in list){
  if (item instanceof UsernamePasswordCredentialsImpl ) {
    if( "admin".equals(((UsernamePasswordCredentialsImpl)item).getUsername())) {
      credentials = item
    }
  }
}

// Set git scm in job
def scm = new hudson.plugins.git.GitSCM("{giturl}")
scm.userRemoteConfigs[0].credentialsId = credentials.getId()
mavenModuleSet.setScm(scm)

instance.save();