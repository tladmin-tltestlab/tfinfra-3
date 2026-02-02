locals {
  services = [
    "compute.googleapis.com",
    "storage-api.googleapis.com",
    "logging.googleapis.com"
  ]
}

#module "vm-instances" {
#  source           = "./instances"
#  zone    = "europe-west3-a"
#  instance_network = google_compute_network.mynetwork.self_link
#}

#ensures all APIs required are enabled
resource "google_project_service" "enabled_apis" {
  for_each = toset(local.services)
  project = "tltestlab-project3"
  service = each.key
  disable_on_destroy = false
}

resource "google_compute_network" "mynetwork" {
  name = "mynetwork"
  auto_create_subnetworks = "true"
  #ensures Compute Engine API is enabled whih is required for VPC creation
  depends_on = [google_project_service.enabled_apis]
}
