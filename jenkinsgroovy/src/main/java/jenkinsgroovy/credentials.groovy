import com.cloudbees.plugins.credentials.CredentialsScope
import com.cloudbees.plugins.credentials.SystemCredentialsProvider
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl

def globalDomain = Domain.global()
def credentialsStore = SystemCredentialsProvider.getInstance().getStore();

def credentials = new UsernamePasswordCredentialsImpl(
    CredentialsScope.GLOBAL,
    null,
    "Utilisateur pour GitBlit",
    "admin",
    "admin",
    )
def result = credentialsStore.addCredentials(globalDomain, credentials)
if (!result) {
  println("Echec de création du crédential")
}
