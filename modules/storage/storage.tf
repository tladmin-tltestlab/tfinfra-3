resource "google_storage_bucket" "test-bucket-for-state" {
  count = var.enable_compute_lab ? 1 : 0
  name        = "tltestlab-project3-02-02-26"
  # Google Cloud offers a "Free Tier" for storage, but it is strictly limited to specific US regions
  location    = "us-central1"
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
}