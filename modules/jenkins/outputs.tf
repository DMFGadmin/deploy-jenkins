output "jenkins_ext_address" {
  value = google_compute_address.jenkins-external-access.address
}

output "jenkins_server" {
  value = google_compute_instance.jenkins-server.name
}