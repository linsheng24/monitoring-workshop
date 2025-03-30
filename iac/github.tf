resource "github_repository" "web_app_example" {
  name        = "web-app-example"
  description = "This is an example repository"

  visibility = "public"
}

resource "github_actions_secret" "DOCKER_USERNAME" {
  repository      = github_repository.web_app_example.name
  secret_name     = "DOCKER_USERNAME"
  plaintext_value = var.dockerhub_username
}

resource "github_actions_secret" "DOCKER_PASSWORD" {
  repository      = github_repository.web_app_example.name
  secret_name     = "DOCKER_PASSWORD"
  plaintext_value = var.dockerhub_password
}

resource "null_resource" "push_to_github" {
  depends_on = [github_repository.web_app_example]

  triggers = {
    directory_hash = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
      cd repositories/web-app-example;
      git init;
      git remote add origin https://github.com/${var.repository_username}/${github_repository.web_app_example.name}.git;
      git add .;
      git commit -m "Initial commit";
      git branch -M main;
      git push https://${var.repository_username}:${var.repository_password}@github.com/${var.repository_username}/${github_repository.web_app_example.name}.git main;
    EOT
  }
}