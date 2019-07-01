data "ignition_systemd_unit" "coreos_nvidia_service" {
  name    = "coreos-nvidia.service"
  content = file("${path.module}/files/coreos-nvidia.service")
}

output "coreos_nvidia_service" {
  value = data.ignition_systemd_unit.coreos_nvidia_service.id
}

