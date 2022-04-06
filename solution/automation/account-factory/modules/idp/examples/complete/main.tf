terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = "1.127.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
  required_version = ">=0.12"

  backend "oss" {
    bucket              = "bucket-with-terraform-state1"
    prefix              = "path/mystate"
    key                 = "{state_key}"
    region              = "cn-hangzhou"
    tablestore_endpoint = "https://terraform-hz-1.cn-hangzhou.ots.aliyuncs.com"
    tablestore_table    = "statelock"
    endpoint            = "oss-cn-hangzhou.aliyuncs.com"
  }
}

provider "alicloud" {
  alias = "rd_role"
  assume_role {
    role_arn           = format("acs:ram::%s:role/ResourceDirectoryAccountAccessRole", var.account_id)
    session_name       = "AccountLandingZoneSetup"
    session_expiration = 999
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
