resource "google_storage_bucket" "main" {
  name                        = var.md_metadata.name_prefix
  labels                      = var.md_metadata.default_tags
  location                    = local.gcp_region
  force_destroy               = true
  uniform_bucket_level_access = false

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  cors {
    origin          = ["https://${local.domain}"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

resource "google_compute_backend_bucket" "main" {
  name        = var.md_metadata.name_prefix
  bucket_name = google_storage_bucket.main.name
  enable_cdn  = true
}

resource "google_storage_default_object_acl" "main" {
  bucket      = google_storage_bucket.main.name
  role_entity = ["READER:allUsers"]
}

resource "google_storage_bucket_object" "index" {
  name    = "index.html"
  content = "Hello, World!"
  bucket  = google_storage_bucket.main.name

  depends_on = [
    google_storage_default_object_acl.main
  ]
}

resource "google_storage_bucket_object" "not_found" {
  name    = "404.html"
  content = "404 not found."
  bucket  = google_storage_bucket.main.name

  depends_on = [
    google_storage_default_object_acl.main
  ]
}
