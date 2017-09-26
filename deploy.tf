variable "do_token" {}
variable "ssh_hash" {}

variable "droplet_name" {}
variable "droplet_image_name" {}
variable "droplet_region" {}
variable "droplet_size" {}
variable "domain" {}

variable "public_key" {}
variable "private_key" {}

variable s3_access_key {}
variable s3_secret_key {}
variable s3_region {}
variable s3_bucket {}
variable s3_key {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a web server
resource "digitalocean_droplet" "web" {
  image  = "${var.droplet_image_name}"
  name   = "${var.droplet_name}"
  region = "${var.droplet_region}"
  size   = "${var.droplet_size}"
  ssh_keys = ["${var.ssh_hash}"]

  connection {
    type = "ssh"
    host = "${digitalocean_droplet.web.ipv4_address}"
    port = 22
    timeout = "5m"
    user = "root"
    private_key = "${file("id_rsa_digitalocean")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update"
    ]
  }

  provisioner "file" {
    source = "test.txt"
    destination = "test.txt"
  }
}

resource "digitalocean_ssh_key" "default" {
  name       = "SSH Key"
  public_key = "${file("id_rsa_digitalocean.pub")}"

}

terraform {

  backend "s3" {
    access_key = "${var.s3_access_key}"
    secret_key = "${var.s3_secret_key}"
    region = "${var.s3_region}"
    bucket = "${var.s3_bucket}"
    key = "state"
  }
}