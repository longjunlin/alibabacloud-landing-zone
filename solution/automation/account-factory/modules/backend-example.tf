# {state_key} should be replaced at each step
terraform {
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