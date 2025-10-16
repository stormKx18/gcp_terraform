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
