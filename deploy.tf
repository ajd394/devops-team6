variable "do_token" {}
variable "ssh_hash" {}

variable "droplet_name" {}
variable "droplet_image_name" {}
variable "droplet_region" {}
variable "droplet_size" {}
variable "domain" {}

variable "public_key" {}
variable "private_key" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a web server
resource "digitalocean_droplet" "web" {
  image  = "ubuntu-16-04-x64"
  name   = "web-1"
  region = "nyc2"
  size   = "512mb"
}
