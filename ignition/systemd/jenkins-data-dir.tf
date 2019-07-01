data "template_file" "jenkins_data_dir_service" {
  template = file("${path.module}/files/jenkins-data-dir.service.tpl")

  vars = {
    data_dir = "/data-a/jenkins"
  }
}

data "ignition_systemd_unit" "jenkins_data_dir_service" {
  name    = "jenkins-data-dir.service"
  content = data.template_file.jenkins_data_dir_service.rendered
}

output "jenkins_data_dir_service" {
  value = data.ignition_systemd_unit.jenkins_data_dir_service.id
}

