import hudson.model.*
import hudson.security.*
import jenkins.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()

// Create security realm
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
instance.setSecurityRealm(hudsonRealm)

// Create user admin
hudsonRealm.createAccount("admin", "{{jenkins_admin_password}}")
def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, "admin")

// Build permission class
class BuildPermission {
  static buildNewAccessList(userOrGroup, permissions) {
	def newPermissionsMap = [:]
	permissions.each {
	  newPermissionsMap.put(Permission.fromId(it), userOrGroup)
	}
	return newPermissionsMap
  }
}

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
  "hudson.model.Item.Cancel"
]

usersAuthenticated = BuildPermission.buildNewAccessList("authenticated", usersPermissions)
usersAuthenticated.each { p, u -> strategy.add(p, u) }

instance.setAuthorizationStrategy(strategy)
instance.save()
