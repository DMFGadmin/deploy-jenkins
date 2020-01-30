data "terraform_remote_state" "project-and-networks" {
  backend = "remote"
  config = {
    organization = "AFRLDigitalMFG"
    workspaces = {
      name = "jenkins_standalone_project"
    }
  }
}

resource "google_compute_address" "jenkins-external-access" {
  name    =  "jenkins-external-access-address"
  address_type = "EXTERNAL"
  description = "Used to access a Jenkins instance securely"
  network_tier = "PREMIUM"
  region      = var.region
  project     = var.project_id
}

resource google_compute_firewall "allow-jenkins-external-access" {
  name    = "allow-access-to-jenkins"
  network = "projects/${var.project_id}/global/networks/${data.terraform_remote_state.project-and-networks.outputs.jenkins-standalone-project-network-name}"
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
  target_tags = [var.jenkins_access_source_tags]
  source_ranges = ["${var.source_range1}","${var.source_range2}"]
}

resource google_compute_firewall "allow-iap-access" {
  name    = "allow-iap-access"
  network = "projects/${var.project_id}/global/networks/${data.terraform_remote_state.project-and-networks.outputs.jenkins-standalone-project-network-name}"
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = [var.iap_tags]
  source_ranges = ["${var.iap_source_cidr}"]
}

resource "google_compute_instance" "jenkins-server" {
  name         = "afrl-jenkins-server-001"
  project = var.project_id
  machine_type = "n1-standard-2"
  tags = ["${var.jenkins_access_source_tags}", "${var.iap_tags}"]

  zone = var.zone

  boot_disk {
    initialize_params {
      image = "projects/${var.project_id}/global/images/jenkins-image-for-deployment"
      size = 20
      type  = "pd-standard"
    }
  }


  network_interface {
    subnetwork = "projects/${var.project_id}/regions/${var.region}/subnetworks/${data.terraform_remote_state.project-and-networks.outputs.jenkins-standalone-project-subnetwork-name}"

    access_config {
      nat_ip = google_compute_address.jenkins-external-access.address
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
