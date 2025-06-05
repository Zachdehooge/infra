# Configure the Docker provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configure the Docker provider for Windows
provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# Create a Docker container that echoes hello world
resource "docker_container" "hello_world" {
  name  = "terraform-hello-world"
  image = docker_image.hello_world.image_id

  # Remove container after it exits
  # rm = true

  # Keep container running briefly to see output
  command = ["sh", "-c", "echo 'Hello World from Terraform and Docker!' && sleep 5"]
}

# Pull the Alpine Linux image
resource "docker_image" "hello_world" {
  name = "alpine:latest"
}

# Output the container ID
output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.hello_world.id
}

# Output the container name
output "container_name" {
  description = "Name of the Docker container"
  value       = docker_container.hello_world.name
}