// Add Maven installations to Jenkins
import jenkins.model.*
import hudson.model.*
import hudson.security.*

// Get Jenkins instance
def instance = Jenkins.getInstance()

// Get Maven extensions
def jdks = instance.getJDKs()

// Reset installations
jdks.clear()

// Add JDK 8
jdks.add(new hudson.model.JDK("JDK 8", "/usr/lib/jvm/java-8-oracle"))
// Add JDK 7
jdks.add(new hudson.model.JDK("JDK 7", "/usr/lib/jvm/java-7-oracle"))
// Add JDK 6
jdks.add(new hudson.model.JDK("JDK 6", "/usr/lib/jvm/java-6-oracle"))

// Save
instance.save()

