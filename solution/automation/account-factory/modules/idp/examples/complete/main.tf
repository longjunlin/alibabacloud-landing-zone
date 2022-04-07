terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }
  }
  backend "oss" {
#    bucket              = "bucket-with-terraform-state1"
#    prefix              = "path/mystate"
#    key                 = "{state_key}"
#    region              = "cn-hangzhou"
#    tablestore_endpoint = "https://terraform-hz-1.cn-hangzhou.ots.aliyuncs.com"
#    tablestore_table    = "statelock"
#    endpoint            = "oss-cn-hangzhou.aliyuncs.com"
  }
}

provider "alicloud" {
  alias = "rd_role"
  assume_role {
    role_arn           = format("acs:ram::%s:role/ResourceDirectoryAccountAccessRole", var.account_id)
    session_name       = "AccountLandingZoneSetup"
    session_expiration = 997
  }
}

module "idp" {
  source = "../../"

  providers = {
    alicloud = alicloud.rd_role
  }
  sso_provider_name = var.sso_provider_name
  encodedsaml_metadata_document = var.encodedsaml_metadata_document
}
