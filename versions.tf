terraform {
  required_version = ">= 0.13"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }
  }
}