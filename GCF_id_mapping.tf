variable "id_mapping_prefix" {}
variable "id_mapping_runtime" {}
variable "id_mapping_memory" {}
variable "id_mapping_entry_point" {}
variable "id_mapping_timeout" {}
variable "id_mapping_repo" {}

# ----------------------------------------------------------------------------------------------------------------------
# Create pubsub topic and subscription

resource "google_pubsub_topic" "id_mapping" {
  name = "${var.global_prefix}${var.id_mapping_prefix}-topic"
}

# ----------------------------------------------------------------------------------------------------------------------
# Upload function to GCS and create Cloud Function

resource "google_storage_bucket_object" "id_mapping" {
  name   = "id_mapping.zip"
  source = "functions/id_mapping.zip"
  bucket = google_storage_bucket.main.id
}

resource "google_cloudfunctions_function" "id_mapping" {
  name                  = "${var.global_prefix}${var.id_mapping_prefix}-function"
  runtime               = var.id_mapping_runtime
  service_account_email = var.service_account_email
  entry_point           = var.id_mapping_entry_point
  available_memory_mb   = var.id_mapping_memory
  timeout               = var.id_mapping_timeout
  ingress_settings      = "ALLOW_ALL"

  source_archive_bucket = google_storage_bucket.main.name
  source_archive_object = google_storage_bucket_object.id_mapping.name


  # source_repository {
  #   url = var.upload_xdr_info_to_bce_repo
  # }

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.id_mapping.id
  }

  environment_variables = {
    PROJECT_ID = var.project_id,
    TIMEOUT    = 20,
    RETRY      = 3,
    XDR_KEY    = var.xdr_key,
    XDR_KEY_ID = var.xdr_key_id,
    BASE_URL   = var.xdr_base_url
  }

  labels = {
    deployment-tool = "console-cloud"
  }

}
