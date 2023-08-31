locals {
  data_infrastructure = {
    id  = google_storage_bucket.main.name
  }
  data_security = {
    iam = {
      read = {
        role      = "roles/storage.objectViewer"
        condition = "resource.name.startsWith(\"projects/_/buckets/${google_storage_bucket.main.name}\")"
      }
      read_write = {
        role      = "roles/storage.objectCreator"
        condition = "resource.name.startsWith(\"projects/_/buckets/${google_storage_bucket.main.name}\")"
      }
    }
  }
  specs_gcp = {
    project = local.gcp_project_id
    service = "Cloud Storage"
  }

  artifact_gcs_bucket = {
    data = {
      infrastructure = local.data_infrastructure
      security       = local.data_security
    }
    specs = {
      gcp = local.specs_gcp
    }
  }
}

resource "massdriver_artifact" "gcs_bucket" {
  field                = "gcs_bucket"
  provider_resource_id = google_storage_bucket.main.id
  name                 = "GCS Bucket ${var.md_metadata.name_prefix} ${google_storage_bucket.main.id}"
  artifact             = jsonencode(local.artifact_gcs_bucket)
}
