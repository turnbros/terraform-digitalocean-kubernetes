data "digitalocean_kubernetes_versions" "eligible_versions" {
  version_prefix = var.k8s_version
}

resource "random_pet" "nodegroup_name" {
  count = length(var.cluster_node_groups)
}

resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name          = var.name
  region        = var.region
  version       = var.k8s_version == null ? data.digitalocean_kubernetes_versions.eligible_versions.latest_version : data.digitalocean_kubernetes_versions.eligible_versions.latest_version
  vpc_uuid      = var.vpc_uuid
  auto_upgrade  = var.auto_upgrade
  surge_upgrade = var.surge_upgrade

  dynamic "node_pool" {
    for_each = var.cluster_node_groups
    content {
      name       = random_pet.nodegroup_name[node_pool.key].id
      size       = node_pool.value.size
      node_count = node_pool.value.node_count
      auto_scale = node_pool.value.auto_scale
      min_nodes  = node_pool.value.min_nodes
      max_nodes  = node_pool.value.max_nodes
      labels     = merge(node_pool.value.labels, local.default_node_labels)
      tags       = concat(node_pool.value.tags, local.default_cluster_tags)
    }
  }
  tags = concat(var.tags, local.default_cluster_tags)
}