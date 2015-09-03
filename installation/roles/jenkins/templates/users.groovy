import hudson.model.*
import hudson.security.*
import jenkins.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()

if (instance.getSecurityRealm() instanceof HudsonPrivateSecurityRealm) {
  def hudsonSecurity = (HudsonPrivateSecurityRealm)instance.getSecurityRealm()
  
  // create users
  hudsonSecurity.createAccount("user1", "{{jenkins_user1_password}}")
  hudsonSecurity.createAccount("user2", "{{jenkins_user2_password}}")
  
}

instance.save()

