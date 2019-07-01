variable "cluster_domain_suffix" {
  description = "Queries for domains with the suffix will be answered by kube-dns"
  type        = string
  default     = "cluster.local"
}

variable "cluster_name" {
  description = "Unique cluster name"
  type        = string
}

variable "k8s_domain_name" {
  description = "Controller DNS name which resolves to a controller instance. Workers and kubeconfig's will communicate with this endpoint (e.g. cluster.example.com)"
  type        = string
}

variable "ca_certificate" {
  description = "Existing PEM-encoded CA certificate (generated if blank)"
  type        = string
}

variable "ca_key_alg" {
  description = "Algorithm used to generate ca_key (required if ca_cert is specified)"
  type        = string
  default     = "RSA"
}

variable "ca_private_key" {
  description = "Existing Certificate Authority private key (required if ca_certificate is set)"
  type        = string
}

# This is a hack. We need a first run for bootkube module to create assets
# in which this variable will be set to false as assets that will be copied
# as ignition files to the server haven't already been created
variable "create_bootkube_assets_ignition_files" {
  default = false
}

variable "k8s_ip" {
  description = "IP that will be use to access k8s API"
}

variable "external_apiserver_port" {
  description = "Port that will balance between k8s api servers"
  default     = "443"
}

variable "internal_apiserver_port" {
  description = "Port will be used internally by k8s api servers"
  default     = "6443"
}

# These two variables are the result of not being able to use filesystem
# reuse semantics in ignition 2.1. These are not related to root filesystem
# but with the data partition. Set them to true the first time you install
# a server if you want partitions/filesystems to be created from scratch
variable "wipe_worker_filesystems" {
  default = false
}

variable "wipe_controller_filesystems" {
  default = false
}


# We don't have list of maps in terraform
# These list MUST be ordered so they match 
variable "controller_internal_ips" {
  type = list(string)
}

variable "controller_server_ids" {
  type = list(string)
}

variable "controller_domains" {
  type = list(string)
}

variable "controller_internal_macs" {
  type = list(string)
}

variable "controller_external_macs" {
  type = list(string)
}

variable "worker_internal_ips" {
  type = list(string)
}

variable "worker_server_ids" {
  type = list(string)
}

variable "worker_domains" {
  type = list(string)
}

variable "worker_internal_macs" {
  type = list(string)
}

variable "worker_external_macs" {
  type = list(string)
}

variable "prometheus_worker_internal_ips" {
  type = list(string)
}

variable "prometheus_worker_server_ids" {
  type = list(string)
}

variable "prometheus_worker_domains" {
  type = list(string)
}

variable "prometheus_worker_internal_macs" {
  type = list(string)
}

variable "prometheus_worker_external_macs" {
  type = list(string)
}

variable "elasticsearch_worker_internal_ips" {
  type = list(string)
}

variable "elasticsearch_worker_server_ids" {
  type = list(string)
}

variable "elasticsearch_worker_internal_macs" {
  type = list(string)
}

variable "elasticsearch_worker_external_macs" {
  type = list(string)
}

variable "elasticsearch_worker_domains" {
  type = list(string)
}

variable "postgres_worker_internal_ips" {
  type = list(string)
}

variable "postgres_worker_internal_macs" {
  type = list(string)
}

variable "postgres_worker_external_macs" {
  type = list(string)
}

variable "postgres_worker_server_ids" {
  type = list(string)
}

variable "postgres_worker_domains" {
  type = list(string)
}

variable "kubelet_image_tag" {
  description = "Version of the kubelet"
  default     = "v1.11.8"
}
