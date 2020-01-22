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
  network = "projects/${var.project_id}/global/networks/${var.network}"
  project = var.project_id
  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }
  target_tags = [var.jenkins_access_source_tags]
  source_ranges = ["${var.source_range1}","${var.source_range2}"]
}

resource "google_compute_instance" "jenkins-server" {
  name         = "jenkins-server-001"
  project = var.project_id
  machine_type = "n1-standard-2"
  tags = ["${var.jenkins_access_source_tags}", "bar"]

  zone = var.zone

  boot_disk {
    initialize_params {
      image = "projects/${var.project_id}/global/images/jenkins-ssl-image"
      size = 20
      type  = "pd-standard"
    }
  }


  network_interface {
    subnetwork = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.subnetwork}"

    access_config {
      nat_ip = google_compute_address.jenkins-external-access.address
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
