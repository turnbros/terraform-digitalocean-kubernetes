terraform {
  required_version = ">= 0.13"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
    random = {
      source = "hashicorp/random"
      version = "2.3.0"
    }
  }
}