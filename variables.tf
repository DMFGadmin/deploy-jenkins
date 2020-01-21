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

variable "jenkins_instance_metadata" {
  description = "Additional metadata to pass to the Jenkins master instance"
  type        = map(string)
  default     = {}
}

variable "subnetwork" {
  description = "The GCP subnetwork to launch the instance in"
  default     = "default"
}

variable "jenkins_access_source_tags" {
  description = ""
}

variable "source_ranges" {
  description = "The name of the zone into which to deploy Jenkins workers"
}