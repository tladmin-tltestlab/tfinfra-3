#uncomment this resource block to create a resource for the manually created GCE instance
resource "google_compute_instance" "manual_vm-1" {
  name         = "tf-instance-1"
  zone         = var.zone
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
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

resource "google_compute_instance" "manual_vm-2" {
  name         = "tf-instance-2"
  zone         = var.zone
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
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



#uncomment this import block to map the import of a manually created GCE instance to the Terraform resource
#import {
#  to = google_compute_instance.manual_vm-1
#  id = "projects/testlab-project3/zones/us-central1-a/instances/my-manual-vm-1"
#}

#import {
#  to = google_compute_instance.manual_vm-2
#  id = "projects/testlab-project3/zones/us-central1-a/instances/my-manual-vm-2"
#}