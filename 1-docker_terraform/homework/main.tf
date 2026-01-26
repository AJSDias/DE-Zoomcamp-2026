terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  # Credentials only needs to be set if you do not have the GOOGLE_APPLICATION_CREDENTIALS
  project = "de-zoomcamp26-terraform-test"
  region  = "europe-west1"
}

resource "google_storage_bucket" "data-lake-bucket" {
  name          = "de_zoomcamp26_test_bucket"
  location      = "EU"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = "de_zoomcamp26_test_dataset"
  project    = "de-zoomcamp26-terraform-test"
  location   = "EU"
}