
locals {
  base_statements = [
    {
      Sid      = "S3ListBucket"
      Effect   = "Allow"
      Action   = ["s3:ListBucket"]
      Resource = "arn:aws:s3:::${module.personal_web.s3_bucket}"
    },
    {
      Sid    = "S3ObjectPermissions"
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:PutObjectAcl",
        "s3:GetObjectAcl"
      ]
      Resource = "arn:aws:s3:::${module.personal_web.s3_bucket}/*"
    },
    {
      Sid    = "CloudFrontInvalidation"
      Effect = "Allow"
      Action = [
        "cloudfront:CreateInvalidation",
        "cloudfront:GetDistribution",
        "cloudfront:GetInvalidation"
      ]
      Resource = "arn:aws:cloudfront::${data.aws_caller_identity.account.account_id}:distribution/${module.personal_web.cf_id}"
    }
  ]

  statements = local.base_statements
}

resource "aws_iam_policy" "deploy_sync_and_invalidate" {
  name        = "${var.name}-deploy-sync-invalidate"
  description = "Allows S3 sync to the deploy bucket and CloudFront invalidation"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.statements
  })
}
output "deploy_policy_arn" {
  value = aws_iam_policy.deploy_sync_and_invalidate.arn
}
