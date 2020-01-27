variable "region" {
  description = "The region to deploy to"
  default     = "us-central1"
}

variable "jenkins_access_source_tags" {
  description = "firewall tags to allow access to jenkins server"
}

variable "source_range1" {
  description = "source ranges for access to jenkins server"
}

variable "source_range2" {
  description = "source ranges for access to jenkins server"
}

variable "zone" {
  description = "what zone should this server be deployed in?"
}