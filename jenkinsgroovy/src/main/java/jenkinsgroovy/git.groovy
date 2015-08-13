// Add Git client to Jenkins
import jenkins.model.*
import hudson.model.*
import hudson.security.*

// Get Jenkins instance
def instance = Jenkins.getInstance()

// Get Maven extensions
def extensions = instance.getExtensionList(hudson.plugins.git.GitTool.DescriptorImpl.class)[0]
def installations = (extensions.installations as List)


// Reset installations
installations.clear()

// Add Git
installations.add(new hudson.plugins.git.GitTool("Default", "/usr/bin/git", []))

// Save
extensions.installations=installations
extensions.save()

