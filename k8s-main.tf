resource "digitalocean_project_resources" "barfoo" {
  project = data.digitalocean_project.foo.id
  resources = [
    digitalocean_droplet.foobar.urn
  ]
}

data "digitalocean_kubernetes_versions" "example" {
  version_prefix = "1.18."
}

resource "digitalocean_kubernetes_cluster" "foo" {
  name         = "foo"
  region       = "nyc1"
  auto_upgrade = true
  version      = data.digitalocean_kubernetes_versions.example.latest_version

  node_pool {
    name       = "default"
    size       = "s-1vcpu-2gb"
    node_count = 3
  }
}