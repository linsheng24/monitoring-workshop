variable "repository_url" {
  description = "The URL of the Git repository"
  type        = string
}

variable "repository_username" {
  description = "The username for accessing the Git repository"
  type        = string
}

variable "repository_password" {
  description = "The password or token for accessing the Git repository"
  type        = string
}

variable "dockerhub_username" {
  description = "The username for accessing Docker Hub"
  type        = string
}

variable "dockerhub_password" {
  description = "The password for accessing Docker Hub"
  type        = string
}

variable "discord_webhook_url" {
  description = "The Discord webhook URL for notifications"
  type        = string
}