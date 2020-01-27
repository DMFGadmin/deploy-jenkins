module "deploy_jenkins" {
  source          = "./modules/jenkins"
  jenkins_access_source_tags = var.jenkins_access_source_tags
  source_range1 = var.source_range1
  source_range2 = var.source_range2
  zone      = var.zone
}