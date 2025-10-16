terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.7.0"
    }
  }
}

provider "google" {
  project     = "terraform-gcp-475214"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "keys.json"
}


resource "google_storage_bucket" "GCS1" {
  name     = "bucket-from-tf-vcjt-2025"
  location = "us-central1"
}