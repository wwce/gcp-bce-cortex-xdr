variable "reader_feeder_prefix" {}
variable "reader_feeder_runtime" {}
variable "reader_feeder_memory" {}
variable "reader_feeder_entry_point" {}
variable "reader_feeder_timeout" {}
variable "reader_feeder_repo" {}

# ----------------------------------------------------------------------------------------------------------------------
# Create pubsub topic and subscription

resource "google_pubsub_topic" "reader_feeder" {
  name = "${var.global_prefix}${var.reader_feeder_prefix}-topic"
}

# ----------------------------------------------------------------------------------------------------------------------
# Upload function to GCS and create Cloud Function

resource "google_storage_bucket_object" "reader_feeder" {
  name   = "reader_feeder.zip"
  source = "functions/reader_feeder.zip"
  bucket = google_storage_bucket.main.id
}

resource "google_cloudfunctions_function" "reader_feeder" {
  name                  = "${var.global_prefix}${var.reader_feeder_prefix}-function"
  runtime               = var.reader_feeder_runtime
  service_account_email = var.service_account_email
  entry_point           = var.reader_feeder_entry_point
  available_memory_mb   = var.reader_feeder_memory
  timeout               = var.reader_feeder_timeout
  ingress_settings      = "ALLOW_ALL"

  source_archive_bucket = google_storage_bucket.main.name
  source_archive_object = google_storage_bucket_object.reader_feeder.name

  # source_repository {
  #   url = var.upload_xdr_info_to_bce_repo
  # }

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.reader_feeder.id
  }

  environment_variables = {
    XDR_KEY    = var.xdr_key,
    XDR_KEY_ID = var.xdr_key_id,
    BASE_URL   = var.xdr_base_url,
    TOPIC      = google_pubsub_topic.id_mapping.name,
    PROJECT_ID = var.project_id
  }

  labels = {
    deployment-tool = "console-cloud"
  }

}

# ----------------------------------------------------------------------------------------------------------------------
# Create Cloud Scheduler Job

variable "reader_feeder_schedule" {}

resource "google_cloud_scheduler_job" "reader_feeder" {
  name      = "${var.global_prefix}${var.reader_feeder_prefix}-scheduler"
  time_zone = var.scheduler_time_zone
  schedule  = var.reader_feeder_schedule

  pubsub_target {
    data       = base64encode("{}") # e30=  
    topic_name = google_pubsub_topic.reader_feeder.id
  }

  retry_config {
    max_backoff_duration = "3600s"
    max_doublings        = 5
    max_retry_duration   = "0s"
    min_backoff_duration = "5s"
  }

}

