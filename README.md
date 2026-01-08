# bymor-frontend-pbrand

Minimal personal brand static site (HTML + CSS) with Terraform infra to host on AWS S3 + CloudFront.

Quick start
1. Edit site under app/www/.
2. Terraform infra:
   cd infra
   terraform init
   terraform apply
3. Upload site:
   aws s3 sync ../app/www s3://<bucket_name> --delete
4. Invalidate CloudFront if needed:
   aws cloudfront create-invalidation --distribution-id <distribution_id> --paths "/*"

Prerequisites: Terraform, AWS CLI configured.
