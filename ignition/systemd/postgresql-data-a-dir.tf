data "template_file" "postgresql_data_a_dir_service" {
  template = file("${path.module}/files/postgresql-data-a-dir.service.tpl")

  vars = {
    data_dir = "/data-a/postgresql"
  }
}

data "ignition_systemd_unit" "postgresql_data_a_dir_service" {
  name    = "postgresql-data-a-dir.service"
  content = data.template_file.postgresql_data_a_dir_service.rendered
}

output "postgresql_data_a_dir_service" {
  value = data.ignition_systemd_unit.postgresql_data_a_dir_service.id
}

