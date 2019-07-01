data "ignition_file" "nvidia_device_plugin" {
  filesystem = "root"
  path       = "${var.output_dir}/01-nvidia-device-plugin.yaml"
  mode       = "0644"

  content {
    content = "${file("${path.module}/files/nvidia-device-plugin.yaml")}"
  }
}

output "assets" {
  value = [
    "${data.ignition_file.nvidia_device_plugin.id}",
  ]
}
