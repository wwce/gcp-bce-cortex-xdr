variable spanner_prefix {}
variable spanner_config {}
variable spanner_node_count {}
variable spanner_deletion_protection {}

# -----------------------------------------------------------------------------------
# Create spanner instance and database
resource "google_spanner_instance" "spanner" {
  display_name = "xdr-bce-db"
  name         = "xdr-bce-db"
  config       = var.spanner_config
  num_nodes    = var.spanner_node_count
}

resource "google_spanner_database" "spanner" {
  instance            = google_spanner_instance.spanner.name
  name                = "xdr_bce_data"
  deletion_protection = var.spanner_deletion_protection
  
  ddl = [
    "CREATE TABLE endpoint_mapping (xdr_agent_id STRING(1024),bce_device_id STRING(1024),) PRIMARY KEY(xdr_agent_id)",
    "CREATE TABLE health_score (xdr_agent_id STRING(1024),health_score STRING(1024),) PRIMARY KEY(xdr_agent_id)",
    "CREATE TABLE xdr_bce (xdr_id STRING(1024),bce_id STRING(1024),) PRIMARY KEY(bce_id)",
    "CREATE TABLE xdr_info (xdr_id STRING(1024),health_score STRING(1024),is_isolated STRING(1024),endpoint_status STRING(1024),) PRIMARY KEY(xdr_id)"
  ]

}