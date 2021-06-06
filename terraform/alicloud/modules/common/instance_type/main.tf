locals {
  gw_types = [
    "ecs.c5.large",
    "ecs.c5.xlarge",
    "ecs.c5.2xlarge",
    "ecs.c5.3xlarge",
    "ecs.c5.4xlarge",
    "ecs.c5.6xlarge",
    "ecs.c5.8xlarge",
    "ecs.c5.16xlarge"
  ]
  mgmt_types = [
    "ecs.hfg6.large",
    "ecs.hfg6.xlarge",
    "ecs.hfg6.2xlarge",
    "ecs.hfg6.3xlarge",
    "ecs.hfg6.4xlarge",
    "ecs.hfg6.6xlarge",
    "ecs.hfg6.8xlarge",
    "ecs.hfg6.10xlarge",
    "ecs.hfg6.16xlarge",
    "ecs.hfg6.20xlarge"
  ]
}

locals {
  gw_values = var.chkp_type == "gateway" ? local.gw_types : []
  mgmt_values = var.chkp_type == "management" ? local.mgmt_types : []
  allowed_values = coalescelist(local.gw_values, local.mgmt_values)
  is_allowed_type = index(local.allowed_values, var.instance_type)
}