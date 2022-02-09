variable "upload_xdr_info_to_bce_prefix" {}
variable "upload_xdr_info_to_bce_runtime" {}
variable "upload_xdr_info_to_bce_memory" {}
variable "upload_xdr_info_to_bce_entry_point" {}
variable "upload_xdr_info_to_bce_timeout" {}
variable "upload_xdr_info_to_bce_repo" {}

# ----------------------------------------------------------------------------------------------------------------------
# Create pubsub topic and subscription

resource "google_pubsub_topic" "upload_xdr_info_to_bce" {
  name = "${var.global_prefix}${var.upload_xdr_info_to_bce_prefix}-topic"
}

# ----------------------------------------------------------------------------------------------------------------------
# Upload function to GCS and create Cloud Function

resource "google_storage_bucket_object" "upload_xdr_info_to_bce" {
  name   = "upload_xdr_info_to_bce.zip"
  source = "functions/upload_xdr_info_to_bce.zip"
  bucket = google_storage_bucket.main.id
}

resource "google_cloudfunctions_function" "upload_xdr_info_to_bce" {
  name                  = "${var.global_prefix}${var.upload_xdr_info_to_bce_prefix}-function"
  runtime               = var.upload_xdr_info_to_bce_runtime
  service_account_email = var.service_account_email
  entry_point           = var.upload_xdr_info_to_bce_entry_point
  available_memory_mb   = var.upload_xdr_info_to_bce_memory
  timeout               = var.upload_xdr_info_to_bce_timeout
  ingress_settings      = "ALLOW_ALL"


  source_archive_bucket = google_storage_bucket.main.name
  source_archive_object = google_storage_bucket_object.upload_xdr_info_to_bce.name

  # source_repository {
  #   url = var.upload_xdr_info_to_bce_repo
  # }


  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.upload_xdr_info_to_bce.id
  }

  environment_variables = {
    CUSTOMER_ID = var.customer_id,
    EMAIL       = var.customer_email,
    PARTNER_ID  = "742dbfbb-8f6b-4c69-96ed-54c6b9e5e95f",
    PROJECT_ID  = var.project_id,
    BASE_URL   = var.xdr_base_url
    CRED_JSON  = var.cred_json
  }


  labels = {
    deployment-tool = "console-cloud"
  }

}


# ----------------------------------------------------------------------------------------------------------------------
# Create Cloud Scheduler Job

variable "upload_xdr_info_to_bce_schedule" {}

resource "google_cloud_scheduler_job" "upload_xdr_info_to_bce" {
  name      = "${var.global_prefix}${var.upload_xdr_info_to_bce_prefix}-scheduler"
  time_zone = var.scheduler_time_zone
  schedule  = var.upload_xdr_info_to_bce_schedule

  pubsub_target {
    data       = base64encode("{}") # e30=  
    topic_name = google_pubsub_topic.upload_xdr_info_to_bce.id
  }

  retry_config {
    max_backoff_duration = "3600s"
    max_doublings        = 5
    max_retry_duration   = "0s"
    min_backoff_duration = "5s"
  }

}
