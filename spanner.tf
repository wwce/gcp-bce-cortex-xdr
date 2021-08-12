variable spanner_prefix {}
variable spanner_config {}
variable spanner_node_count {}
variable spanner_deletion_protection {}

# -----------------------------------------------------------------------------------
# Create spanner instance and database
resource "google_spanner_instance" "spanner" {
  display_name = "${var.global_prefix}${var.spanner_prefix}-instance"
  config       = var.spanner_config
  num_nodes    = var.spanner_node_count
}

resource "google_spanner_database" "spanner" {
  instance            = google_spanner_instance.spanner.name
  name                = "${var.global_prefix}${var.spanner_prefix}-db"
  deletion_protection = var.spanner_deletion_protection
  
  ddl = [
    "CREATE TABLE endpoint_mapping (xdr_agent_id STRING(1024),bce_device_id STRING(1024),) PRIMARY KEY(xdr_agent_id)",
    "CREATE TABLE health_score (xdr_agent_id STRING(1024),health_score STRING(1024),) PRIMARY KEY(xdr_agent_id)",
    "CREATE TABLE xdr_bce (xdr_id STRING(1024),bce_id STRING(1024),) PRIMARY KEY(bce_id)",
    "CREATE TABLE xdr_info (xdr_id STRING(1024),health_score STRING(1024),is_isolated STRING(1024),endpoint_status STRING(1024),) PRIMARY KEY(xdr_id)"
  ]

}



# SPANNER INSTANCE (xdr-bce-db)
// gcloud spanner instances describe xdr-bce-db 
 
#config: projects/function-receiver/instanceConfigs/regional-us-central1
#displayName: xdr-bc-db
#name: projects/function-receiver/instances/xdr-bce-db
#nodeCount: 1
#processingUnits: 1000
#state: READY


# SPANNER DATABASE 
// gcloud spanner databases describe xdr_bce_data --instance xdr-bce-db

#createTime: '2021-07-06T19:17:17.973956Z'
#earliestVersionTime: '2021-08-11T16:35:55.044115Z'
#encryptionInfo:
#- encryptionType: GOOGLE_DEFAULT_ENCRYPTION
#name: projects/function-receiver/instances/xdr-bce-db/databases/xdr_bce_data
#state: READY
#versionRetentionPeriod: 1h  - no terraform equivalent