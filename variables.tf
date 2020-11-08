variable "parent_project_id" {
  type = string
}

variable "name" {
  type = string
}

variable "domain" {
  type = string
}

variable "region" {
  type = string
}

variable "k8s_version" {
  type    = string
  default = null
}

variable "vpc_uuid" {
  type = string
}

variable "auto_upgrade" {
  type = bool
}

variable "surge_upgrade" {
  type = bool
}

variable "default_cluster_node_group" {
  type = object({
    size : string,
    node_count : number,
    auto_scale : bool,
    min_nodes : number,
    max_nodes : number,
    tags : list(string),
    labels : map(string),
  })
}

variable "extra_cluster_node_groups" {
  type = list(object({
    size : string,
    node_count : number,
    auto_scale : bool,
    min_nodes : number,
    max_nodes : number,
    tags : list(string),
    labels : map(string),
  }))
}

#ariable "cluster_services" {
# type = object({
#   cert_manager : object({
#
#   })
#   traefik : object({
#     namespace : string,
#     log_level : string,
#     replicas : number,
#     rolling_update_max_surge : number,
#     rolling_update_max_unavailable : number,
#     pod_termination_grace_period_seconds : number
#   })
#   # With any luck we'll be able to default `argocd` to null here. Until then we'll just have to do that in the calling module.
#   argocd : object({
#     namespace : string,
#     server_replicas : number,
#     repo_replicas : number,
#     enable_dex : bool,
#     enable_ha_redis : bool,
#     oidc_name : string,
#     oidc_issuer : string,
#     oidc_client_id : string,
#     oidc_client_secret : string,
#     oidc_requested_scopes : list(string),
#     oidc_requested_id_token_claims : map(any)
#   })
# })
#

variable "tags" {
  type = list(string)
}