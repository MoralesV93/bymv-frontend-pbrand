locals{
    default_region = "eu-central-1"
    default_terraform_version = "1.3.0"
    default_AWS_provider_version = "5.10"
    default_terraform_bucket_name="tf-infrastructure-management"
    default_terraform_dynamodb_name="tf-infrastructure-management-table"
    default_AWS_profile_name="bymv-dev"
    
}
generate "terraform_main" {
  path = "main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

terraform {
  backend "s3" {
    bucket   = "${local.default_terraform_bucket_name}"
    key      = "${path_relative_to_include()}/terraform.tfstate"
    region   = "eu-central-1"
    dynamodb_table = "${local.default_terraform_dynamodb_name}"
    profile  = "${local.default_AWS_profile_name}"
  }
}
  EOF

}


generate "providers" {
  path = "common.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
##### Common Providers #####

terraform {
  required_version = "${local.default_terraform_version}"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> ${local.default_AWS_provider_version}"
    }
  }
}

provider "aws" {
  profile = var.profile
  region = var.region
  default_tags {
    tags = {
        domain_name = var.domain_name
        service = var.service
        namespace = var.namespace
        environment = terraform.workspace
        location="${path_relative_to_include()}"
    }
  }
}

##### Common variables ######
variable "region"{
  description = "default region associated with this account"
  type = string
  default = "${local.default_region}"
}
variable "profile"{
    type = string
    default = "${local.default_AWS_profile_name}"
}
variable "tf_bucket_name"{
    type = string
    default = "${local.default_terraform_bucket_name}"
}
variable "tf_dynamodb_table"{
    type = string
    default = "${local.default_terraform_dynamodb_name}"
}
EOF
}

generate "variables"{
  path = "variables.tf"
  if_exists = "skip"
  contents = <<EOF
variable "service"{
  description = "type of service"
  type = string
}
variable "namespace"{
  description = "string of services that this infra belongs to"
  type = string
}

variable "domain_name"{
  description = "Main domain where this resources belongs to"
  type = string
}
  EOF
}

generate "terraform_version" {
  path = ".terraform-version"
  disable_signature = true
  if_exists = "skip"
  contents = <<EOF
${local.default_terraform_version}
EOF
}