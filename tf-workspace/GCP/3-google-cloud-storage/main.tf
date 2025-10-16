/*For production add lifecycle policy to bucket*/
resource "google_storage_bucket" "GCS1"{
    name = "bucket-from-tf-vcjt-2025-v2"
    location = "us-central1"
    storage_class = "STANDARD"
    labels = {
      env : "tf_env"
      dep : "compliance"
    }
    uniform_bucket_level_access = true

    lifecycle {
      prevent_destroy = true
    }

    lifecycle_rule {
      condition {
        age = 30
      }
      action {
        type = "SetStorageClass"
        storage_class ="NEARLINE"
      }
    }
    #Retention for 10 days (864000 seconds)
    retention_policy {
      retention_period = 60
    }
}

resource "google_storage_bucket_object" "picture"{
    name = "avatar_logo"
    bucket = google_storage_bucket.GCS1.name
    source = "eyes.jpg"
    content_type = "image/jpeg"
}

resource "google_storage_bucket_iam_member" "viewers" {
  for_each = toset([
    "user:vicjaime92@gmail.com",
    "user:vicjaime922@gmail.com",
  ])

  bucket = google_storage_bucket.GCS1.name
  role   = "roles/storage.objectViewer"
  member = each.value
}
