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
instance.setAuthorizationStrategy(strategy)

instance.save()
