variable "region" {
  description = "The region to deploy to"
  default     = "us-central1"
}

variable "jenkins_access_source_tags" {
  description = ""
}

variable "source_range1" {
  description = "The name of the zone into which to deploy Jenkins workers"
}

variable "source_range2" {
  description = "The name of the zone into which to deploy Jenkins workers"
}

variable "zone" {
  description = "which zone should the jenkins server be deployed"
}

variable "project_id" {
  description = "which project to deploy jenkins into"
}

variable "iap_source_cidr" {
  description = "which project to deploy jenkins into"
}

variable "iap_tags" {
  description = "which project to deploy jenkins into"
}