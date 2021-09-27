
# ----------------------------------------------------------------------------------------------------------------------
# Environment specific variables (must be configured by end-user)

# project_id            = ""
# xdr_key               = ""
# xdr_key_id            = ""
# xdr_base_url          = "https://<your_url>.xdr.us.paloaltonetworks.com/public_api/v1/"
# customer_id           = ""
# customer_email        = "your_email@email.com"
# partner_id            = ""
# service_account_email = ""
# project_auth_file     = "" #  Only required if deploying outside of your GCP project's cloud shell.  If true, Uncomment line 4 in main.tf 
# region                = "us-central1"
# scheduler_time_zone   = "America/New_York"
global_prefix         = "xdr-"

# ----------------------------------------------------------------------------------------------------------------------
# Common variables (do not need to be configured by end-user)

update_xdr_info_prefix             = "update_xdr_info"
update_xdr_info_memory             = 256
update_xdr_info_entry_point        = "hello_pubsub"
update_xdr_info_runtime            = "python37"
update_xdr_info_timeout            = 300
update_xdr_info_repo               = "https://storage.googleapis.com/gcf-upload-us-central1-195de627-f166-4bf8-bd20-f8d725d760bd/0dc775f9-e82b-4ac4-ac2e-8ebe36f32a9d.zip"
update_xdr_info_schedule           = "*/8 * * * *" # 0

upload_xdr_info_to_bce_prefix      = "upload_xdr_info_to_bce"
upload_xdr_info_to_bce_memory      = 256
upload_xdr_info_to_bce_entry_point = "hello_pubsub"
upload_xdr_info_to_bce_runtime     = "python37"
upload_xdr_info_to_bce_timeout     = 60
upload_xdr_info_to_bce_repo        = "https://storage.googleapis.com/gcf-upload-us-central1-195de627-f166-4bf8-bd20-f8d725d760bd/930f842d-01a3-45e1-81a8-25e42e497c33.zip"
upload_xdr_info_to_bce_schedule    = "*/8 * * * *" # 5

reader_feeder_prefix               = "reader_feeder"
reader_feeder_memory               = 256
reader_feeder_entry_point          = "hello_pubsub"
reader_feeder_runtime              = "python37"
reader_feeder_timeout              = 60
reader_feeder_repo                 = "https://storage.googleapis.com/gcf-upload-us-central1-195de627-f166-4bf8-bd20-f8d725d760bd/31bfbbf2-3f60-4055-bcda-1aea8ca880ec.zip"
reader_feeder_schedule             = "*/8 * * * *" #0

id_mapping_prefix                  = "id_mapping"
id_mapping_memory                  = 256
id_mapping_entry_point             = "hello_pubsub"
id_mapping_runtime                 = "python39"
id_mapping_timeout                 = 60
id_mapping_repo                    = "https://storage.googleapis.com/gcf-upload-us-central1-195de627-f166-4bf8-bd20-f8d725d760bd/b5b6bff1-27ac-47c3-8a5e-4721f8494e26.zip"

spanner_prefix                     = "xdr-bce"
spanner_config                     = "regional-us-central1"
spanner_node_count                 = 1
spanner_deletion_protection        = false

