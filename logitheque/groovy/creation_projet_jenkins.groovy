import hudson.maven.MavenModuleSet
import hudson.model.JDK
import jenkins.model.Jenkins

import com.cloudbees.plugins.credentials.CredentialsScope
import com.cloudbees.plugins.credentials.SystemCredentialsProvider
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl


def instance = Jenkins.getInstance()
MavenModuleSet mavenModuleSet = instance.createProject(MavenModuleSet.class,"{job}");
mavenModuleSet.setRunHeadless( true );

//def jdk = new JDK("JDK 8",System.getProperty("java.home"))
def jdk = new JDK("{jdk}",null)
mavenModuleSet.setJDK(jdk)

mavenModuleSet.setMaven("{maven}")
mavenModuleSet.setRootPOM("pom.xml")
mavenModuleSet.setGoals("{goals}")

global_domain = Domain.global()
credentials_store = SystemCredentialsProvider.getInstance().getStore();

list = credentials_store.getCredentials(global_domain)

def credentials=null 
for (item in list){	
	if (item instanceof UsernamePasswordCredentialsImpl && "admin".equals(((UsernamePasswordCredentialsImpl)item).getUsername())) {
		credentials = item	
	}	 
}

def scm = new hudson.plugins.git.GitSCM("{giturl}")
scm.userRemoteConfigs[0].credentialsId = credentials.getId()

mavenModuleSet.setScm(scm)
instance.save();