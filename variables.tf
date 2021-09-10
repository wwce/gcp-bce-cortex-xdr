variable "project_id" {
  description = "GCP project name"
}

variable "project_auth_file" {
  description = "GCP Project auth file"
  default     = null
}

variable "region" {
  description = "GCP deployment region"
}

variable "xdr_key" {
  description = "Enter your Cortex XDR key"
}

variable "xdr_key_id" {
  description = "Enter your Cortex XDR key ID"
}

variable "xdr_base_url" {
  description = "Enter your Cortex XDR base URL"
}

variable "partner_id" {
  description = "Enter the partner ID"
}

variable "customer_id" {
  description = "Enter your customer ID"
}

variable "customer_email" {
  description = "Enter your email address."
}

variable "global_prefix" {
  description = "Enter a naming prefix.  This prefix will be prepended to all resources created."
}

variable "scheduler_time_zone" {
  description = "Enter a valid time-zone for cloud scheduler (i.e. America/New_York)"
}

variable "service_account_email" {}
