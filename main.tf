data "digitalocean_kubernetes_versions" "eligible_versions" {
  version_prefix = var.k8s_version
}

resource "random_pet" "default_nodegroup_name" {
}

resource "random_pet" "extra_nodegroup_names" {
  count = length(var.extra_cluster_node_groups)
}

resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name          = var.name
  region        = var.region
  version       = var.k8s_version == null ? data.digitalocean_kubernetes_versions.eligible_versions.latest_version : var.k8s_version
  vpc_uuid      = var.vpc_uuid
  auto_upgrade  = var.auto_upgrade
  surge_upgrade = var.surge_upgrade

  node_pool {
    name       = random_pet.default_nodegroup_name.id
    size       = var.default_cluster_node_group.size
    node_count = var.default_cluster_node_group.node_count
    auto_scale = var.default_cluster_node_group.auto_scale
    min_nodes  = var.default_cluster_node_group.min_nodes
    max_nodes  = var.default_cluster_node_group.max_nodes
    labels     = merge(var.default_cluster_node_group.labels, local.default_node_labels)
    tags       = concat(var.default_cluster_node_group.tags, local.default_cluster_tags)
  }

  tags = concat(var.tags, local.default_cluster_tags)
}

resource "digitalocean_kubernetes_node_pool" "kubernetes_cluster_node_pool" {
  count      = length(var.extra_cluster_node_groups)
  cluster_id = digitalocean_kubernetes_cluster.kubernetes_cluster.id
  name       = random_pet.extra_nodegroup_names[count.index].id
  size       = var.extra_cluster_node_groups[count.index].size
  node_count = var.extra_cluster_node_groups[count.index].node_count
  auto_scale = var.extra_cluster_node_groups[count.index].auto_scale
  min_nodes  = var.extra_cluster_node_groups[count.index].min_nodes
  max_nodes  = var.extra_cluster_node_groups[count.index].max_nodes
  labels     = merge(var.extra_cluster_node_groups[count.index].labels, local.default_node_labels)
  tags       = concat(var.extra_cluster_node_groups[count.index].tags, local.default_cluster_tags)
}