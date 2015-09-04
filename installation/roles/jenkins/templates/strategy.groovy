import hudson.model.*
import hudson.security.*
import jenkins.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()

// Build permission
class BuildPermission {
  static buildNewAccessList(userOrGroup, permissions) {
	def newPermissionsMap = [:]
	permissions.each {
	  newPermissionsMap.put(Permission.fromId(it), userOrGroup)
	}
	return newPermissionsMap
  }
}

if (instance.getAuthorizationStrategy() instanceof GlobalMatrixAuthorizationStrategy) {
  def strategy = (GlobalMatrixAuthorizationStrategy)instance.getAuthorizationStrategy()
  
  //---------------------------- anonymous strategy permissions----------------------------------
  anonymousPermissions = [
	"hudson.model.Hudson.Read",
	"hudson.model.Item.Discover",
	"hudson.model.Item.Read",
  ]
  
  anonymous = BuildPermission.buildNewAccessList("anonymous", anonymousPermissions)
  anonymous.each { p, u -> strategy.add(p, u) }
  
  //---------------------------- users strategy permissions --------------------------------------
  usersPermissions = [
	"hudson.model.Hudson.Read",
	"hudson.model.Item.Build",
	"hudson.model.Item.Configure",
	"hudson.model.Item.Create",
	"hudson.model.Item.Delete",
	"hudson.model.Item.Discover",
	"hudson.model.Item.Read",
	"hudson.model.Item.Workspace",
	"hudson.model.Item.Cancel",
  "hudson.model.Hudson.RunScripts",
  "com.cloudbees.plugins.credentials.CredentialsProvider.View"
  ]
  
  usersAuthenticated = BuildPermission.buildNewAccessList("authenticated", usersPermissions)
  usersAuthenticated.each { p, u -> strategy.add(p, u) }
  
}

instance.save()
