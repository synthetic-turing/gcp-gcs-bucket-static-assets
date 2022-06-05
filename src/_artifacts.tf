locals {
  data_infrastructure = {
    id  = google_storage_bucket.main.name
    url = local.full_url
  }
  data_security = {
  }
  specs_gcp = {
    project = local.gcp_project_id
    service = "Cloud Storage"
  }

  artifact_static_bucket = {
    data = {
      infrastructure = local.data_infrastructure
      security       = local.data_security
    }
    specs = {
      gcp = local.specs_gcp
    }
  }
}

resource "massdriver_artifact" "static_bucket" {
  field                = "static_bucket"
  provider_resource_id = google_storage_bucket.main.id
  type                 = "gcp-bucket-https"
  name                 = "HTTPS Bucket ${var.md_metadata.name_prefix} ${google_storage_bucket.main.id}"
  artifact             = jsonencode(local.artifact_static_bucket)
}
