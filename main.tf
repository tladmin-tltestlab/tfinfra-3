#module "vm-instances" {
#  source           = "./instances"
#  zone    = "europe-west3-a"
#  instance_network = google_compute_network.mynetwork.self_link
#}

resource "google_compute_network" "mynetwork" {
  name = "mynetwork"
  # RESOURCE properties go here
  auto_create_subnetworks = "true"
}