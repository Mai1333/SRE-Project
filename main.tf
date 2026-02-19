terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine" #to make sure terraform uses new version of docker API
}
resource "docker_image" "sre_api_image" {
  name = "my-sre-api:latest"
}

resource "docker_container" "sre_api_container" {
  name = "sre-production-api"
  image = docker_image.sre_api_image.image_id

  ports {
    internal = 8000
    external = 8000
  }

  #if app crashes, docker will always restart it
  restart = "always"
}

