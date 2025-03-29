resource "kubernetes_secret" "argoproj_repository_creds" {
  metadata {
    name      = "argocd-repository-creds"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    url      = var.repository_url
    type     = "git"
    username = var.repository_username
    password = var.repository_password
  }
}
