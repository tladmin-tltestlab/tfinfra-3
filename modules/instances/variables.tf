variable "enable_compute_lab" {
  description = "Toggle to enable/disable the compute lab resources"
  type        = bool
  default     = true
}

variable "instance_network" {}

### from here is how the challenge quiklab should look

variable "region" {
  default = "europe-west3"
}
variable "zone" {
  default = "europe-west3-a"
}
variable "project_id" {
  default = "tltestlab-project3"
}