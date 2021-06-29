//PLEASE refer to README.md for accepted values FOR THE VARIABLES BELOW

// --- Credentials ---
//region = "us-east-1"
//alicloud_access_key_ID = "12345"
//alicloud_secret_access_key = "12345"

// --- VPC Network Configuration ---
vpc_cidr = "10.0.0.0/16"
cluster_vswitchs_map = {
  "us-east-1a" = 1
}
management_vswitchs_map = {
  "us-east-1a" = 2
}
private_vswitchs_map = {
  "us-east-1a" = 3
}
vswitchs_bit_length = 8

// --- ECS Instance Configuration ---
gateway_name = "Check-Point-Cluster-tf"
gateway_instance_type = "ecs.c5.xlarge"
key_name = "omrina-n-virginia"
allocate_and_associate_eip = true
volume_size = 100
ram_role_name = ""
instance_tags = {
  key1 = "value1"
  key2 = "value2"
}

// --- Check Point Settings ---
gateway_version = "R81-BYOL"
admin_shell = "/bin/bash"
gateway_SICKey = "12345678"
gateway_password_hash = "$1$b5fKUYps$EUG5ndQsq41YcZwHUhLCe/"

// --- Advanced Settings ---
resources_tag_name = "omrina-cluster-master"
gateway_hostname = "omrina"
allow_upload_download = true
gateway_bootstrap_script = ""
primary_ntp = ""
secondary_ntp = ""
