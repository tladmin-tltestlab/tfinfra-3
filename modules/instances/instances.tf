#uncomment this resource block to create a resource for the manually created GCE instance
resource "google_compute_instance" "manual_vm-1" {
  name         = "tf-instance-1"
  zone         = var.zone
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    network = var.instance_network
  }
  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT
  allow_stopping_for_update = true
  # ... define the rest of the config to match the real resource ...
}



