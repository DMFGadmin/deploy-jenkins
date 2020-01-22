module "deploy_jenkins" {
  source          = "./modules/jenkins"
  network = var.network
  project_id = var.project_id
  jenkins_access_source_tags = var.jenkins_access_source_tags
  source_range1 = var.source_range1
  source_range2 = var.source_range2
  subnetwork = var.subnetwork
  zone      = var.zone
}