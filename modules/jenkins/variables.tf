
variable "project_id" {
  description = "The project ID to deploy to"
}

variable "region" {
  description = "The region to deploy to"
  default     = "us-central1"
}

variable "network" {
  description = "The GCP network to launch the instance in"
}

variable "subnetwork" {
  description = "The GCP subnetwork to launch the instance in"
}

variable "jenkins_access_source_tags" {
  description = "firewall tags to allow access to jenkins server"
}

variable "source_ranges" {
  description = "source ranges for access to jenkins server"
}