resource "google_compute_address" "jenkins-external-access" {
  name    =  "jenkins-external-access-address"
  address_type = "EXTERNAL"
  description = "Used to access a Jenkins instance securely"
  network_tier = "STANDARD"
  region      = var.region
  project     = var.project_id
}

resource google_compute_firewall "allow-jenkins-access" {
  name    = "allow-access-to-jenkins"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = [var.jenkins_access_source_tags]
  source_ranges = ["${var.source_ranges}"]
}

resource "google_compute_instance" "jenkins-server" {
  name         = "jenkins_server"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "projects/${var.project_id}/global/images/jenkins-image-for-deployment"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    subnetwork = "projects/afrl-jenkins-01/regions/us-central1/subnetworks/afrl-jenkins-subnet-01"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
