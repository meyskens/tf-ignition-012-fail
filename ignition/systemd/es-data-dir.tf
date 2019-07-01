data "template_file" "es_data_dir_service" {
  template = file("${path.module}/files/es-data-dir.service.tpl")

  vars = {
    data_dir = "/data/elasticsearch"
  }
}

data "ignition_systemd_unit" "es_data_dir_service" {
  name    = "es-data-dir.service"
  content = data.template_file.es_data_dir_service.rendered
}

output "es_data_dir_service" {
  value = data.ignition_systemd_unit.es_data_dir_service.id
}

