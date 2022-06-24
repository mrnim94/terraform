resource "google_compute_address" "static_ip" {
  name ="vm-console"
}

resource "google_compute_instance" "vm-from-tf" {
  name = "vm-console"
  zone = "asia-southeast1-b"
  machine_type = "e2-custom-4-4096"

  tags = ["allow-ssh"]

  allow_stopping_for_update = true

  network_interface {
    network = "${var.network}-${var.env_name}"
    subnetwork = "${var.subnetwork}-${var.env_name}"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }


  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20210916"
      size = 35
      
    }
    auto_delete = false
  }

  metadata = {
    ssh-keys = "${split("@", var.compute_engine_service_account)[0]}:${file(var.key_pairs["root_public_key"])}"
  }

  labels = {
    "env" = "vm-console"
  }

  
  scheduling {
    preemptible = false
    automatic_restart = false
  }
  
  service_account {
    email = var.compute_engine_service_account
    scopes = [ "cloud-platform" ]
  }

  lifecycle {
    ignore_changes = [
      attached_disk
    ]
  }

}

resource "google_compute_disk" "disk-1" {
  name = "disk-1"
  size = 15
  zone = "asia-southeast1-b"
  type = "pd-ssd"
}

resource "google_compute_attached_disk" "adisk" {
  disk = google_compute_disk.disk-1.id
  instance = google_compute_instance.vm-from-tf.id
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = "${var.network}-${var.env_name}"
  target_tags   = ["allow-ssh"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
}

output "public_ip" {
  value = google_compute_address.static_ip.address
}

