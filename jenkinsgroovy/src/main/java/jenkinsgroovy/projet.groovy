import hudson.maven.MavenModuleSet
import hudson.model.JDK
import jenkins.model.Jenkins

import com.cloudbees.plugins.credentials.CredentialsScope
import com.cloudbees.plugins.credentials.SystemCredentialsProvider
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl


def instance = Jenkins.getInstance()
MavenModuleSet mavenModuleSet = instance.createProject(MavenModuleSet.class,"job01");
mavenModuleSet.setRunHeadless( true );

def jdk = new JDK("JDK 8",null)
mavenModuleSet.setJDK(jdk)

mavenModuleSet.setMaven("MAVEN 3.3")
mavenModuleSet.setRootPOM("pom.xml")
mavenModuleSet.setGoals("clean install")

global_domain = Domain.global()
credentials_store = SystemCredentialsProvider.getInstance().getStore();

list = credentials_store.getCredentials(global_domain)
def credentials=null 
for (item in list){	
	if (item instanceof UsernamePasswordCredentialsImpl && "admin".equals(((UsernamePasswordCredentialsImpl)item).getUsername())) {
		credentials = item	
	}	 
}

if (credentials == null) {  
	credentials = new UsernamePasswordCredentialsImpl(
			CredentialsScope.GLOBAL,
			null,
			"Utilisateur pour GitBlit",
			"admin",
			"admin",
			)
	credentials_store.addCredentials(global_domain, credentials)
}

def scm = new hudson.plugins.git.GitSCM("git://172.16.20.102/devops/victime.git")
scm.userRemoteConfigs[0].credentialsId = credentials.getId()

mavenModuleSet.setScm(scm)
instance.save();