# Compress source code
data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/hello_world"
  output_path = "${path.module}/function.zip"
}

# Bucket for source
resource "google_storage_bucket" "function_bucket" {
    name = "function_bucket_tf_vcjt_1337"
    location = "us-central1"
    storage_class = "STANDARD"
    force_destroy = true
}

# Upload source code as zip file
resource "google_storage_bucket_object" "source_code" {
    name = "function.zip"
    bucket = google_storage_bucket.function_bucket.name
    source = data.archive_file.function_zip.output_path
}


# Deploy 2nd Gen function
resource "google_cloudfunctions2_function" "fun_from_tf" {
  name        = "fun-from-tf-v3"
  location    = "us-central1"
  description = "This is my first 2nd gen function from Terraform"

  build_config {
    runtime     = "python313"
    entry_point = "hello_http"
    source {
      storage_source {
        bucket = google_storage_bucket.function_bucket.name
        object = google_storage_bucket_object.source_code.name
      }
    }
  }

  service_config {
    max_instance_count = 1
    available_memory   = "128Mi"
    timeout_seconds    = 3600
    all_traffic_on_latest_revision = true
    ingress_settings   = "ALLOW_ALL"
  }


}

#Policy binding
resource "google_cloud_run_service_iam_member" "invoker" {
  location = google_cloudfunctions2_function.fun_from_tf.location
  project  = google_cloudfunctions2_function.fun_from_tf.project
  service  = google_cloudfunctions2_function.fun_from_tf.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
