# Pulls the image
#resource "docker_image" "app" {
#  count = var.tocount
#  name = var.ct-image[count.index] 
#}

resource "docker_image" "image" {
  count = var.tocount
  name = var.ct-image[count.index]
  build {
    context = "/srv/checkout/app/."
    tag     = [var.ct-image[count.index]]
  }
}




