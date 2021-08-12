variable "project_id" {
  description = "GCP project name"
}

variable "project_auth_file" {
  description = "GCP Project auth file"
  default     = null
}

variable "region" {
  description = "GCP deployment region"
  default     = "us-east4"
}

variable "xdr_key" {
  description = "Enter your Cortex XDR key"
}

variable "xdr_key_id" {
  description = "Enter your Cortex XDR key ID"
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

variable "scheduler_time_zone" {}

variable "service_account_email" {}
