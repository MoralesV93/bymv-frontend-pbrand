locals {
  //aliases             = try(data.terraform_remote_state.acm.outputs.domain_name, var.aliases)
  aliases = var.aliases
  //acm_certificate_arn = try(data.terraform_remote_state.acm.outputs.certification_arn, var.acm_certification)
  acm_certificate_arn = var.acm_certification
  //parent_zone_id      = try(data.terraform_remote_state.acm.outputs.route_53_zone_id, var.route_53_zone_id)
  parent_zone_id = var.route_53_zone_id
}
