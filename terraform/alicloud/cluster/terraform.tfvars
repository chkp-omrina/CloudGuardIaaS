// --- creds ---
region = "us-east-1"

// --- VPC Network Configuration ---
vpc_id = "vpc-"
cluster_vswitch_id = "vsw-"
mgmt_vswitch_id = "vsw-"
private_vswitch_id = "vsw-"
private_route_table = "vtb-"

// --- ECS Instance Configuration ---
gateway_name = "Check-Point-Cluster-tf"
gateway_instance_type = "ecs.c5.xlarge"
key_name = "key"
allocate_and_associate_eip = true
volume_size = 100
ram_role_name = "role_name"
instance_tags = {
  key1 = "value1"
  key2 = "value2"
}

// --- Check Point Settings ---
gateway_version = "R81-BYOL"
admin_shell = "/bin/bash"
gateway_SICKey = "12345678"
gateway_password_hash = "12345678"

// --- Advanced Settings ---
resources_tag_name = "tag-name"
gateway_hostname = "gw-hostname"
allow_upload_download = true
gateway_bootstrap_script = ""
primary_ntp = ""
secondary_ntp = ""
