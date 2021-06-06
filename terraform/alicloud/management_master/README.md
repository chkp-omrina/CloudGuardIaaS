# Check Point Management master Server Terraform module for AliCloud

Terraform module which deploys a Check Point Management Server into an existing VPC on AliCloud.

These types of Terraform resources are supported:
* [Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html) - management Instance
* [Security group](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)


## Note
- Make sure your region and zone are supporting the management instance types in **modules/common/instance_type/main.tf**
  [Alicloud Instance_By_Region](https://ecs-buy.aliyun.com/instanceTypes/?spm=a2c63.p38356.879954.139.1eeb2d44eZQw2m#/instanceTypeByRegion)
  
## Configuration
- Best practice is to configure credentials in the Environment variables - [Alicloud provider](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
- Static credentials can be provided by adding an alicloud_access_key_ID and alicloud_secret_access_key in management_master/**terraform.tfvars** file as follows:
```
region = "us-east-1"
alicloud_access_key_ID = "12345"
alicloud_secret_access_key = "12345"
```
  - In addition, you need to call these variables in the provider and pass it on to the management module in management_master/**main.tf** file as follows:
  ```
  provider "alicloud" {
    region     = var.region
    access_key = var.alicloud_access_key_ID
    secret_key = var.alicloud_secret_access_key
  }

  module "launch_management_into_vpc" {
    source = "../management"
    region = var.region
    alicloud_access_key_ID = var.alicloud_access_key_ID
    alicloud_secret_access_key = var.alicloud_secret_access_key

    ...
   }
  ```

## Usage
- Fill all variables in the management_master/**terraform.tfvars** file with proper values (see below for variables descriptions).
- From a command line initialize the Terraform configuration directory:
        terraform init
- Create an execution plan:
        terraform plan
- Create or modify the deployment:
        terraform apply

### terraform.tfvars variables:
| Name          | Description   | Type          | Allowed values | Default       | Required      |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| vpc_id        | The VPC id in which to deploy | string    | n/a   | n/a   | yes |
| vswitch_id     | Vswitch id                     | string    | n/a   | n/a   | yes  |
|   |   |   |   |   |   |
| instance_name | AliCloud instance name to launch   | string    | n/a   | "CP-Management-tf"  | no  |
| instance_type | AliCloud instance type  | string  | - m5.large <br/> - m5.xlarge <br/> - m5.2xlarge <br/> - m5.4xlarge <br/> - m5.12xlarge <br/> - m5.24xlarge  | m5.xlarge  | no  |
| key_name | The ECS Key Pair name to allow SSH access to the instances | string  | n/a | n/a | yes |
| eip  | Allocate and associate an elastic IP with the launched instance  | bool  | true/false  | true  | no  |
| volume_size  | Root volume size (GB)  | number  | n/a  | 100  | no  |
| instance_tags  | (Optional) A map of tags as key=value pairs. All tags will be added to the Management ECS Instance  | map(string)  | n/a  | {}  | no  |
|   |   |   |   |   |   |
| gateway_version | Gateway version & license | string | - R81-BYOL | R81-BYOL |
| admin_shell  | Set the admin shell to enable advanced command line configuration  | string  | - /etc/cli.sh <br/> - /bin/bash <br/> - /bin/csh <br/> - /bin/tcsh | /etc/cli.sh | no |
| password_hash | (Optional) Admin user's password hash (use command \"openssl passwd -6 PASSWORD\" to get the PASSWORD's hash) | string | n/a | "" | no |
| hostname  | (Optional) Management prompt hostname  | string  | n/a  | n/a  | no  |
|   |   |   |   |   |   |
| is_primary_management  | Determines if this is the primary Management Server or not  | bool  | true/false  | true  | no  |
| SICKey  | "Mandatory only when deploying a secondary Management Server, the Secure Internal Communication key creates trusted connections between Check Point components. Choose a random string consisting of at least 8 alphanumeric characters  | string  | n/a  | ""  | no  |
| allow_upload_download | Automatically download Blade Contracts and other important data. Improve product experience by sending data to Check Point | bool | n/a | true | no |
| gateway_management  | Select 'Over the internet' if any of the gateways you wish to manage are not directly accessed via their private IP address  | string  | - Locally managed <br/> - Over the internet  | Locally managed  | no  |
| admin_cidr  | (CIDR) Allow web, SSH, and graphical clients only from this network to communicate with the Management Server  | string  | valid CIDR  | 0.0.0.0/0  | no  |
| gateway_addresses  | (CIDR) Allow gateways only from this network to communicate with the Management Server  | string  | valid CIDR  | 0.0.0.0/0  | no  |
| primary_ntp  | (Optional)  | string  | n/a  | ""  | no  |
| secondary_ntp  | (Optional)  | string  | n/a  | ""  | no  |
| bootstrap_script | (Optional) Semicolon (;) separated commands to run on the initial boot | string | n/a | "" | no |

## Example for terraform.tfvars
```
// --- VPC Network Configuration ---
vpc_cidr = "10.0.0.0/16"
public_vswitchs_map = {
  "us-east-1a" = 1
}
private_vswitchs_map = {
  "us-east-1a" = 2
}
vswitchs_bit_length = 8

// --- ECS Instances Configuration ---
instance_name = "CP-Management-tf"
instance_type = "m5.xlarge"
key_name = "privatekey"
eip = true
volume_size = 100
instance_tags = {
  key1 = "value1"
  key2 = "value2"
}

// --- Check Point Settings ---
version_license = "R81-BYOL"
admin_shell = "/bin/bash"
password_hash = "12345678"
hostname = "mgmt-tf"

// --- Security Management Server Settings ---
is_primary_management = "true"
SICKey = ""
allow_upload_download = "true"
gateway_management = "Locally managed"
admin_cidr = "0.0.0.0/0"
gateway_addresses = "0.0.0.0/0"
primary_ntp = ""
secondary_ntp = ""
bootstrap_script = "echo 12345678"
```

## Outputs
| Name  | Description |
| ------------- | ------------- |
| vpc_id  | The id of the deployed vpc  |
| vpc_public_vswitchs_ids_list  | A list of the private vswitchs ids  |
| vpc_private_vswitchs_ids_list  | A list of the private vswitchs ids  |
| image_id  | The ami id of the deployed Security Gateway  |
| management_instance_id  | The deployed Management AliCloud instance id  |
| management_instance_name  | The deployed Management AliCloud instance name  |
| management_instance_tags  | The deployed Management AliCloud tags  |
| management_public_ip  | The deployed Management AliCloud public address  |

## Revision History

| Template Version | Description   |
| ---------------- | ------------- |
| __VERSION__ | First release of Check Point CloudGuard Management Terraform deployment into a new VPC in Alibaba cloud. |
| | | |

## License

This project is licensed under the MIT License - see the [LICENSE](../../../LICENSE) file for details
