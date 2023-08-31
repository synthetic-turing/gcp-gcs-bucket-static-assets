resource "google_storage_bucket" "main" {
  name                        = var.md_metadata.name_prefix
  labels                      = var.md_metadata.default_tags
  location                    = local.gcp_region
  force_destroy               = true
  uniform_bucket_level_access = false
}

resource "google_compute_backend_bucket" "main" {
  name        = var.md_metadata.name_prefix
  bucket_name = google_storage_bucket.main.name
}
