variable "enable_compute_lab" {
  description = "Toggle to enable/disable the compute lab resources"
  type        = bool
  default     = true
}
variable "region" {
  default = "europe-west3"
}
variable "zone" {
  default = "europe-west3-a"
}
variable "project_id" {
  default = "tltestlab-project3"
}