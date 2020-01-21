module "deploy_jenkins" {
  source          = "./modules/jenkins"
  network = var.network
  project_id = var.project_id
  jenkins_access_source_tags = var.jenkins_access_source_tags
  source_ranges = var.source_ranges
  subnetwork = var.subnetwork
}