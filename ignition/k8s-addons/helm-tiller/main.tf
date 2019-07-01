# https://github.com/helm/helm/blob/master/docs/rbac.md
# https://docs.helm.sh/install/#using-output
data "ignition_file" "deployment" {
  filesystem = "root"
  path       = "${var.output_dir}/deployment.yaml"
  mode       = "0644"

  content {
    content = file("${path.module}/files/deployment.yaml")
  }
}

data "ignition_file" "service_account" {
  filesystem = "root"
  path       = "${var.output_dir}/service-account.yaml"
  mode       = "0644"

  content {
    content = file("${path.module}/files/service-account.yaml")
  }
}

data "ignition_file" "cluster_role_binding" {
  filesystem = "root"
  path       = "${var.output_dir}/cluster-role-binding.yaml"
  mode       = "0644"

  content {
    content = file("${path.module}/files/cluster-role-binding.yaml")
  }
}

output "assets" {
  value = [
    data.ignition_file.deployment.id,
    data.ignition_file.service_account.id,
    data.ignition_file.cluster_role_binding.id,
  ]
}

