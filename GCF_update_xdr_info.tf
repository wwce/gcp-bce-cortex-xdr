variable "update_xdr_info_prefix" {}
variable "update_xdr_info_runtime" {}
variable "update_xdr_info_memory" {}
variable "update_xdr_info_entry_point" {}
variable "update_xdr_info_timeout" {}
variable "update_xdr_info_repo" {}

# ----------------------------------------------------------------------------------------------------------------------
# Create pubsub topic and subscription

resource "google_pubsub_topic" "update_xdr_info" {
  name = "${var.global_prefix}${var.update_xdr_info_prefix}-topic"
}

# ----------------------------------------------------------------------------------------------------------------------
# Upload function to GCS and create Cloud Function

resource "google_storage_bucket_object" "update_xdr_info" {
  name   = "update_xdr_info.zip"
  source = "functions/update_xdr_info.zip"
  bucket = google_storage_bucket.main.id
}

resource "google_cloudfunctions_function" "update_xdr_info" {
  name                  = "${var.global_prefix}${var.update_xdr_info_prefix}-function"
  runtime               = var.update_xdr_info_runtime
  service_account_email = var.service_account_email
  entry_point           = var.update_xdr_info_entry_point
  available_memory_mb   = var.update_xdr_info_memory
  timeout               = var.update_xdr_info_timeout
  ingress_settings      = "ALLOW_ALL"

  source_archive_bucket = google_storage_bucket.main.name
  source_archive_object = google_storage_bucket_object.update_xdr_info.name

  # source_repository {
  #   url = var.update_xdr_info_repo
  # }


  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.update_xdr_info.id
  }

  environment_variables = {
    PROJECT_ID = var.project_id,
    XDR_KEY    = var.xdr_key,
    XDR_KEY_ID = var.xdr_key_id
  }

  labels = {
    deployment-tool = "console-cloud"
  }

}

# ----------------------------------------------------------------------------------------------------------------------
# Create Cloud Scheduler Job

variable "update_xdr_info_schedule" {}

resource "google_cloud_scheduler_job" "update_xdr_info" {
  name      = "${var.global_prefix}${var.update_xdr_info_prefix}-scheduler"
  time_zone = var.scheduler_time_zone
  schedule  = var.update_xdr_info_schedule

  pubsub_target {
    data       = base64encode("{}") # e30=  
    topic_name = google_pubsub_topic.update_xdr_info.id
  }

  retry_config {
    max_backoff_duration = "3600s"
    max_doublings        = 5
    max_retry_duration   = "0s"
    min_backoff_duration = "5s"
  }

}
