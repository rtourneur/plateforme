import jenkins.model.Jenkins

import com.cloudbees.plugins.credentials.CredentialsScope
import com.cloudbees.plugins.credentials.SystemCredentialsProvider
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl



def instance = Jenkins.getInstance()

def globalDomain = Domain.global()
def credentialsStore = SystemCredentialsProvider.getInstance().getStore();

def credentials = new UsernamePasswordCredentialsImpl(
    CredentialsScope.GLOBAL,
    null,
    "Utilisateur pour GitBlit",
    "admin",
    "{{gitblit_admin_password}}",
    )
credentialsStore.addCredentials(globalDomain, credentials)

