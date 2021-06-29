provider "alicloud" {
//  region = var.region
//  access_key = var.alicloud_access_key_ID
//  secret_key = var.alicloud_secret_access_key
}

// --- VPC ---
module "launch_vpc" {
  source = "../modules/vpc"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  public_vswitchs_map = var.cluster_vswitchs_map
  management_vswitchs_map = var.management_vswitchs_map
  private_vswitchs_map = var.private_vswitchs_map
  vswitchs_bit_length = var.vswitchs_bit_length
}

resource "alicloud_route_table" "private_vswitch_rt" {
  depends_on = [module.launch_vpc]
  name =  "Internal_Route_Table"
  vpc_id = module.launch_vpc.vpc_id
}
resource "alicloud_route_table_attachment" "private_rt_to_private_vswitchs" {
  depends_on = [module.launch_vpc, alicloud_route_table.private_vswitch_rt]
  route_table_id = alicloud_route_table.private_vswitch_rt.id
  vswitch_id = module.launch_vpc.private_vswitchs_ids_list[0]
}

module "launch_cluster_into_vpc" {
  source = "../cluster"

//  region = var.region
//  alicloud_access_key_ID = var.alicloud_access_key_ID
//  alicloud_secret_access_key = var.alicloud_secret_access_key

  vpc_id = module.launch_vpc.vpc_id
  cluster_vswitch_id = module.launch_vpc.public_vswitchs_ids_list[0]
  mgmt_vswitch_id = module.launch_vpc.management_vswitchs_ids_list[0]
  private_vswitch_id = module.launch_vpc.private_vswitchs_ids_list[0]
  private_route_table = alicloud_route_table.private_vswitch_rt.id
  gateway_name = var.gateway_name
  gateway_instance_type = var.gateway_instance_type
  key_name = var.key_name
  allocate_and_associate_eip = var.allocate_and_associate_eip
  volume_size = var.volume_size
  ram_role_name = var.ram_role_name
  instance_tags = var.instance_tags
  gateway_version = var.gateway_version
  admin_shell = var.admin_shell
  gateway_SICKey = var.gateway_SICKey
  gateway_password_hash = var.gateway_password_hash
  resources_tag_name = var.resources_tag_name
  gateway_hostname = var.gateway_hostname
  allow_upload_download = var.allow_upload_download
  gateway_bootstrap_script = var.gateway_bootstrap_script
  primary_ntp = var.primary_ntp
  secondary_ntp = var.secondary_ntp
}