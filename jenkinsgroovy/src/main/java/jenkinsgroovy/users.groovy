import hudson.model.*
import hudson.security.*
import jenkins.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()

if (instance.getSecurityRealm() instanceof HudsonPrivateSecurityRealm) {
  def hudsonSecurity = (HudsonPrivateSecurityRealm)instance.getSecurityRealm()
  
  // create users
  hudsonSecurity.createAccount("user1", "user1")
  hudsonSecurity.createAccount("user2", "user2")
  
}

instance.save()

