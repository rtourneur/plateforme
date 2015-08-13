// Add Maven installations to Jenkins
import jenkins.model.*
import hudson.model.*
import hudson.security.*

// Get Jenkins instance
def instance = Jenkins.getInstance()

// Get Maven extensions
def extensions = instance.getExtensionList(hudson.tasks.Maven.DescriptorImpl.class)[0]
def installations = (extensions.installations as List)

// Reset installations
installations.clear()

// Add Maven 3
installations.add(new hudson.tasks.Maven.MavenInstallation("MAVEN 3.3", "/usr/lib/maven/apache-maven-3.3.3", []))
// Add Maven 2
installations.add(new hudson.tasks.Maven.MavenInstallation("MAVEN 3.2", "/usr/lib/maven/apache-maven-3.2.5", []))

// Save
extensions.installations=installations
extensions.save()

