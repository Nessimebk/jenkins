terraform {
 required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
 }
}

provider "docker" {
 host     = "ssh://root@10.0.2.5"
 ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

resource "docker_image" "nginx" {
 name         = "nginx:1.21"
 keep_locally = false
}

resource "docker_container" "nginx" {
 image = docker_image.nginx.1.21
 name = "tutorial"
 ports {
    internal = 80
    external = 8000
 }
}

resource "null_resource" "example" {
 depends_on = [docker_container.nginx]

 provisioner "remote-exec" {
    inline = [
      "docker ps"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      host        = "10.0.2.5"
      private_key = file("~/.ssh/id_rsa")
    }
 }
}
