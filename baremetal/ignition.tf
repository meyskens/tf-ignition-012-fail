data "ignition_config" "controller" {
  count = length(var.controller_domains)

  depends_on = ["module.controller_ignition_networkd", "module.controller_ignition_files", "module.controller_ignition_systemd"]

  networkd = [
    element(
      module.controller_ignition_networkd.net_10_external0_link,
      count.index,
    ),
    module.controller_ignition_networkd.net_20_external0_network,
    element(
      module.controller_ignition_networkd.net_10_internal0_link,
      count.index,
    ),
    module.controller_ignition_networkd.net_20_internal0_network,
    module.controller_ignition_networkd.net_10_internal0_k8s_netdev,
    module.controller_ignition_networkd.net_20_internal0_k8s_network,
  ]

  systemd = [
    module.controller_ignition_systemd.data_mount,
    module.controller_ignition_systemd.etcd_data_dir_service,
    element(
      module.controller_ignition_systemd.etcd_member_service,
      count.index,
    ),
    module.controller_ignition_systemd.locksmithd_service,
    module.controller_ignition_systemd.docker_service,
    module.controller_ignition_systemd.wait_for_etcd_service,
    element(
      module.controller_ignition_systemd.kubelet_controller_service,
      count.index,
    ),
    module.controller_ignition_systemd.bootkube_service,
    module.controller_ignition_systemd.haproxy_service,
    module.controller_ignition_systemd.keepalived_service,
    module.controller_ignition_systemd.iptables_restore_service,
    module.controller_ignition_systemd.k8s_addons_service,
  ]

  # In files we have a combination of:
  # - Files from ignition modules
  # - bootkube certificates (from terraform-render-bootkube outputs)
  # - bootkube generated assets (from terraform-render-bootkube assets)
  # - k8s addons
  files = concat([
    module.controller_ignition_files.kubelet_env,
    element(module.controller_ignition_files.hostname, count.index),
    module.controller_ignition_files.max_user_watches_conf,
    module.controller_ignition_files.bootkube_start,
    module.controller_ignition_files.keepalived_conf,
    module.controller_ignition_files.haproxy_conf,
    module.controller_ignition_files.check_tcp_port,
    module.controller_ignition_files.iptables_rules_save,
    module.controller_ignition_files.kubectl,
    module.controller_ignition_files.k8s_addons,
    module.controller_ignition_files.sourced_ps1,
    data.ignition_file.etcd__etcd_client_ca___crt.id,
    data.ignition_file.etcd__etcd_client___crt.id,
    data.ignition_file.etcd__etcd_client___key.id,
    data.ignition_file.etcd__etcd__server_ca___crt.id,
    data.ignition_file.etcd__etcd__server___crt.id,
    data.ignition_file.etcd__etcd__server___key.id,
    data.ignition_file.etcd__etcd__peer_ca___crt.id,
    data.ignition_file.etcd__etcd__peer___crt.id,
    data.ignition_file.etcd__etcd__peer___key.id,
    data.ignition_file.kubeconfig.id
    ],
    module.bootkube_assets.assets, 
    module.helm_tiller_addon.assets
  )
  

  users = module.ignition_users.all
}

data "ignition_config" "worker" {
  count = length(var.worker_domains)

  depends_on = ["module.worker_ignition_networkd", "module.worker_ignition_files", "module.worker_ignition_systemd"]

  networkd = [
    element(
      module.worker_ignition_networkd.net_10_external0_link,
      count.index,
    ),
    module.worker_ignition_networkd.net_20_external0_network,
    element(
      module.worker_ignition_networkd.net_10_internal0_link,
      count.index,
    ),
    module.worker_ignition_networkd.net_20_internal0_network,
    module.worker_ignition_networkd.net_10_internal0_k8s_netdev,
    module.worker_ignition_networkd.net_20_internal0_k8s_network,
  ]

  systemd = [
    module.worker_ignition_systemd.data_a_mount,
    module.worker_ignition_systemd.data_b_mount,
    module.worker_ignition_systemd.data_c_mount,
    module.worker_ignition_systemd.locksmithd_service,
    module.worker_ignition_systemd.docker_service,
    element(
      module.worker_ignition_systemd.kubelet_worker_service,
      count.index,
    ),
    module.worker_ignition_systemd.gluster_service,
  ]

  files = [
    module.worker_ignition_files.kubelet_env,
    element(module.worker_ignition_files.hostname, count.index),
    module.worker_ignition_files.max_user_watches_conf,
    module.worker_ignition_files.sourced_ps1,
    data.ignition_file.kubeconfig.id,
  ]

  users = module.ignition_users.all
}

data "ignition_config" "elasticsearch_worker" {
  count = length(var.elasticsearch_worker_domains)

  depends_on = ["module.elasticsearch_worker_ignition_networkd", "module.elasticsearch_worker_ignition_files", "module.elasticsearch_worker_ignition_systemd"]

  networkd = [
    element(
      module.elasticsearch_worker_ignition_networkd.net_10_external0_link,
      count.index,
    ),
    module.elasticsearch_worker_ignition_networkd.net_20_external0_network,
    element(
      module.elasticsearch_worker_ignition_networkd.net_10_internal0_link,
      count.index,
    ),
    module.elasticsearch_worker_ignition_networkd.net_20_internal0_network,
    module.elasticsearch_worker_ignition_networkd.net_10_internal0_k8s_netdev,
    module.elasticsearch_worker_ignition_networkd.net_20_internal0_k8s_network,
  ]

  systemd = [
    module.elasticsearch_worker_ignition_systemd.data_mount,
    module.controller_ignition_systemd.es_data_dir_service,
    module.elasticsearch_worker_ignition_systemd.locksmithd_service,
    module.elasticsearch_worker_ignition_systemd.docker_service,
    element(
      module.elasticsearch_worker_ignition_systemd.kubelet_elasticsearch_worker_service,
      count.index,
    ),
  ]

  files = [
    module.elasticsearch_worker_ignition_files.kubelet_env,
    element(
      module.elasticsearch_worker_ignition_files.hostname,
      count.index,
    ),
    module.elasticsearch_worker_ignition_files.max_user_watches_conf,
    module.elasticsearch_worker_ignition_files.sourced_ps1,
    data.ignition_file.kubeconfig.id,
  ]

  users = module.ignition_users.all
}

data "ignition_config" "postgres_worker" {
  count = length(var.postgres_worker_domains)

  depends_on = ["module.postgres_worker_ignition_networkd", "module.postgres_worker_ignition_files", "module.postgres_worker_ignition_systemd"]

  networkd = [
    element(
      module.postgres_worker_ignition_networkd.net_10_external0_link,
      count.index,
    ),
    module.postgres_worker_ignition_networkd.net_20_external0_network,
    element(
      module.postgres_worker_ignition_networkd.net_10_internal0_link,
      count.index,
    ),
    module.postgres_worker_ignition_networkd.net_20_internal0_network,
    module.postgres_worker_ignition_networkd.net_10_internal0_k8s_netdev,
    module.postgres_worker_ignition_networkd.net_20_internal0_k8s_network,
  ]

  systemd = [
    module.postgres_worker_ignition_systemd.data_mount,
    module.controller_ignition_systemd.es_data_dir_service,
    module.postgres_worker_ignition_systemd.locksmithd_service,
    module.postgres_worker_ignition_systemd.docker_service,
    element(
      module.postgres_worker_ignition_systemd.kubelet_postgres_worker_service,
      count.index,
    ),
  ]

  files = [
    module.postgres_worker_ignition_files.kubelet_env,
    element(module.postgres_worker_ignition_files.hostname, count.index),
    module.postgres_worker_ignition_files.max_user_watches_conf,
    module.postgres_worker_ignition_files.sourced_ps1,
    data.ignition_file.kubeconfig.id,
  ]

  users = module.ignition_users.all
}

data "ignition_config" "prometheus_worker" {
  count = length(var.prometheus_worker_domains)

  depends_on = ["module.prometheus_worker_ignition_networkd", "module.prometheus_worker_ignition_files", "module.prometheus_worker_ignition_systemd"]

  networkd = [
    element(
      module.prometheus_worker_ignition_networkd.net_10_external0_link,
      count.index,
    ),
    module.prometheus_worker_ignition_networkd.net_20_external0_network,
    element(
      module.prometheus_worker_ignition_networkd.net_10_internal0_link,
      count.index,
    ),
    module.prometheus_worker_ignition_networkd.net_20_internal0_network,
    module.prometheus_worker_ignition_networkd.net_10_internal0_k8s_netdev,
    module.prometheus_worker_ignition_networkd.net_20_internal0_k8s_network,
  ]

  systemd = [
    module.prometheus_worker_ignition_systemd.data_mount,
    module.controller_ignition_systemd.es_data_dir_service,
    module.prometheus_worker_ignition_systemd.locksmithd_service,
    module.prometheus_worker_ignition_systemd.docker_service,
    element(
      module.prometheus_worker_ignition_systemd.kubelet_prometheus_worker_service,
      count.index,
    ),
  ]

  files = [
    module.prometheus_worker_ignition_files.kubelet_env,
    element(
      module.prometheus_worker_ignition_files.hostname,
      count.index,
    ),
    module.prometheus_worker_ignition_files.max_user_watches_conf,
    module.prometheus_worker_ignition_files.sourced_ps1,
    data.ignition_file.kubeconfig.id,
  ]

  users = module.ignition_users.all
}

module "controller_ignition_networkd" {
  source              = "../ignition/networkd"
  server_count        = length(var.controller_domains)
  internal_macs = var.controller_internal_macs
  external_macs = var.controller_external_macs
}

module "worker_ignition_networkd" {
  source              = "../ignition/networkd"
  server_count        = length(var.worker_domains)
  internal_macs = var.worker_internal_macs
  external_macs = var.worker_external_macs
}

module "elasticsearch_worker_ignition_networkd" {
  source              = "../ignition/networkd"
  server_count        = length(var.elasticsearch_worker_domains)
  internal_macs = var.elasticsearch_worker_internal_macs
  external_macs = var.elasticsearch_worker_external_macs
}

module "postgres_worker_ignition_networkd" {
  source              = "../ignition/networkd"
  server_count        = length(var.postgres_worker_domains)
  internal_macs = var.postgres_worker_internal_macs
  external_macs = var.postgres_worker_external_macs
}

module "prometheus_worker_ignition_networkd" {
  source              = "../ignition/networkd"
  server_count        = length(var.prometheus_worker_domains)
  internal_macs = var.prometheus_worker_internal_macs
  external_macs = var.prometheus_worker_external_macs
}

module "controller_ignition_systemd" {
  source                 = "../ignition/systemd"
  filesystem_type        = "xfs"
  controller_domains     = var.controller_domains
  cluster_domain_suffix  = var.cluster_domain_suffix
  k8s_dns_service_ip     = module.bootkube.kube_dns_service_ip
  haproxy_apiserver_port = var.external_apiserver_port
  haproxy_stats_port     = "9000"
}

module "worker_ignition_systemd" {
  source                = "../ignition/systemd"
  filesystem_type       = "xfs"
  worker_domains        = var.worker_domains
  cluster_domain_suffix = var.cluster_domain_suffix
  k8s_dns_service_ip    = module.bootkube.kube_dns_service_ip
}

module "elasticsearch_worker_ignition_systemd" {
  source                       = "../ignition/systemd"
  filesystem_type              = "xfs"
  elasticsearch_worker_domains = var.elasticsearch_worker_domains
  cluster_domain_suffix        = var.cluster_domain_suffix
  k8s_dns_service_ip           = module.bootkube.kube_dns_service_ip
}

module "postgres_worker_ignition_systemd" {
  source                  = "../ignition/systemd"
  filesystem_type         = "xfs"
  postgres_worker_domains = var.postgres_worker_domains
  cluster_domain_suffix   = var.cluster_domain_suffix
  k8s_dns_service_ip      = module.bootkube.kube_dns_service_ip
}

module "prometheus_worker_ignition_systemd" {
  source                    = "../ignition/systemd"
  filesystem_type           = "xfs"
  prometheus_worker_domains = var.prometheus_worker_domains
  cluster_domain_suffix     = var.cluster_domain_suffix
  k8s_dns_service_ip        = module.bootkube.kube_dns_service_ip
}

module "controller_ignition_files" {
  source                       = "../ignition/files"
  kubelet_image_tag            = var.kubelet_image_tag
  domains                      = var.controller_domains
  controller_domains           = var.controller_domains
  keepalived_virtual_ipaddress = var.k8s_ip
  k8s_apiserver_port           = var.internal_apiserver_port
  haproxy_apiserver_port       = var.external_apiserver_port
  haproxy_stats_port           = "9000"
}

module "worker_ignition_files" {
  source            = "../ignition/files"
  kubelet_image_tag = var.kubelet_image_tag
  domains           = var.worker_domains
}

module "elasticsearch_worker_ignition_files" {
  source            = "../ignition/files"
  kubelet_image_tag = var.kubelet_image_tag
  domains           = var.elasticsearch_worker_domains
}

module "postgres_worker_ignition_files" {
  source            = "../ignition/files"
  kubelet_image_tag = var.kubelet_image_tag
  domains           = var.postgres_worker_domains
}

module "prometheus_worker_ignition_files" {
  source            = "../ignition/files"
  kubelet_image_tag = var.kubelet_image_tag
  domains           = var.prometheus_worker_domains
}

module "ignition_users" {
  source = "../ignition/users"
}

module "bootkube_assets" {
  source        = "./bootkube-assets"
  create_assets = var.create_bootkube_assets_ignition_files
}

module "helm_tiller_addon" {
  source = "../ignition/k8s-addons/helm-tiller"
}

