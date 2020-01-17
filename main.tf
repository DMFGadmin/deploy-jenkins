module "deploy_jenkins" {
  source          = "./modules/jenkins"
  network = var.network
  project_id = var.project_id
}