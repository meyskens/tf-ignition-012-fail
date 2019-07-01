module "baremetal" {
  source                 = "./baremetal"
  cluster_name           = "tftest"
  k8s_ip                 = "10.10.10.10"
  k8s_domain_name        = "kube-apiserver.k8s.tftest.dev.srcd.host"
  ca_certificate         = file("./certificates/ca/combined-ca.crt")
  ca_private_key = file(
    "./certificates/ca/signing-ca/private/signing-ca.key",
  )

  controller_server_ids = [
    147763,
    135774,
    135882,
  ]

  controller_internal_ips = [
    "10.10.10.7",
    "10.10.10.8",
    "10.10.10.9",
  ]

  controller_internal_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]

  controller_external_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]

  controller_domains = [
    "controller-1.k8s.tftest.dev.srcd.host",
    "controller-2.k8s.tftest.dev.srcd.host",
    "controller-3.k8s.tftest.dev.srcd.host",
  ]

  worker_server_ids = [
    135010,
  ]

  worker_internal_macs = [
    "00:A0:C9:14:C8:29",
  ]

  worker_external_macs = [
    "00:A0:C9:14:C8:29",
  ]

  worker_internal_ips = [
    "10.10.10.11",
  ]

  worker_domains = [
    "worker-1.k8s.tftest.dev.srcd.host",
  ]

  prometheus_worker_server_ids = [
    139477,
    144925,
  ]

  prometheus_worker_internal_ips = [
    "10.10.10.211",
    "10.10.10.212",
  ]

  prometheus_worker_domains = [
    "prometheus-worker-1.k8s.tftest.dev.srcd.host",
    "prometheus-worker-2.k8s.tftest.dev.srcd.host",
  ]

  prometheus_worker_internal_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]

  prometheus_worker_external_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]


  postgres_worker_server_ids = [
    103383,
    152102,
  ]

  postgres_worker_internal_ips = [
    "10.10.10.221",
    "10.10.10.222",
  ]

  postgres_worker_internal_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]

  postgres_worker_external_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]

  postgres_worker_domains = [
    "postgres-worker-1.k8s.tftest.dev.srcd.host",
    "postgres-worker-2.k8s.tftest.dev.srcd.host",
  ]

  elasticsearch_worker_server_ids = [
    139334,
    139475,
    139476,
  ]

  elasticsearch_worker_internal_ips = [
    "10.10.10.241",
    "10.10.10.242",
    "10.10.10.243",
  ]

  elasticsearch_worker_domains = [
    "elasticsearch-worker-1.k8s.tftest.dev.srcd.host",
    "elasticsearch-worker-2.k8s.tftest.dev.srcd.host",
    "elasticsearch-worker-3.k8s.tftest.dev.srcd.host",
  ]

  elasticsearch_worker_internal_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]

  elasticsearch_worker_external_macs = [
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
    "00:A0:C9:14:C8:29",
  ]

  # This was set to false the first run to let
  # terraform-render-bootkube *actually* create the assets
  create_bootkube_assets_ignition_files = true
}
