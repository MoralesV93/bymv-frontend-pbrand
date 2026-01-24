module "personal_web" {
  source                              = "cloudposse/cloudfront-s3-cdn/aws"
  version                             = "1.1.0"
  namespace                           = var.namespace
  stage                               = terraform.workspace
  name                                = var.name
  aliases                             = local.aliases
  acm_certificate_arn                 = local.acm_certificate_arn
  cloudfront_access_log_create_bucket = false
  cloudfront_access_logging_enabled   = false
  block_origin_public_access_enabled  = true
  origin_force_destroy                = true
  origin_path                         = "/current"
  dns_alias_enabled                   = true
  parent_zone_id                      = local.parent_zone_id
  compress                            = true
  bucket_versioning                   = "Enabled"
}
