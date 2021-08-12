terraform {}

provider "google" {
  credentials = var.project_auth_file
  project     = var.project_id
  region      = var.region
}

resource "random_string" "randomstring" {
  length      = 25
  min_lower   = 15
  min_numeric = 10
  special     = false
}

resource "google_storage_bucket" "main" {
  name          = join("", [var.global_prefix, random_string.randomstring.result])
  force_destroy = true
}

