# bymv-frontend-pbrand

Minimal personal brand static site (HTML + CSS) with Terraform infrastructure to host the site on AWS S3 and distribute via CloudFront.

Overview
--------
This repository contains a small static website (under `app/www`) and the Terraform configuration (under `infra/www/pbrand`) used to provision the hosting stack on AWS (S3 bucket + CloudFront distribution, plus related IAM and S3 settings).

This repository is intended to be a place where I can establish some practices that I usually carry out as a DevOps worker. It will be updated with more features as I work on it.

Repository layout
---------------
- `app/www/` — static site source (HTML, CSS, JS, images).
- `infra/www/pbrand/` — Terraform code and Terragrunt configuration for provisioning S3 + CloudFront and related resources.
- `root.hcl`, `README.md` — repo-level configuration and documentation.

Quick start
-----------
Prerequisites:
- `terraform` (v1.0+ recommended)
- `aws` CLI configured with credentials and default region

1. Review or edit the site files in `app/www/`.

2. Provision infrastructure (example from repo root):

```bash
cd infra/www/pbrand
terraform init
terraform apply
```

The Terraform configuration will create an S3 bucket for hosting and a CloudFront distribution. See `infra/www/pbrand/` for variables and configuration details.

3. Upload static site to S3

Replace `<bucket-name>` with the bucket created by Terraform (check outputs or `infra/www/pbrand/terraform.tfstate`):

```bash
aws s3 sync ../../../../app/www s3://<bucket-name> --delete
```

4. Invalidate CloudFront cache (optional)

If you updated assets and need to force CloudFront to serve fresh files:

```bash
aws cloudfront create-invalidation --distribution-id <distribution_id> --paths "/*"
```

Local preview
-------------
You can preview the static site locally with any static file server. With Python 3 installed:

```bash
cd app/www
python3 -m http.server 8080
# then open http://localhost:8080
```
or running a container with Nginx.

```bash
cd app/www
docker build -t pbrand .
docker run -i -p 8080:80 pbrand
```
Open the browser on http://localhost:8080

Local testing
-------------
You can test the html file using node run scripts. You need NodeJS installed:
```bash
cd app/www
npm run  html-validate
# Linter outputs
```


Terraform / infra notes
----------------------
- Terraform files are in `infra/www/pbrand/` and include variable definitions and Terragrunt layout.
- Sensitive values should be provided via `terraform.tfvars` (not committed) or environment variables.
- The repo contains an example `terraform.tfvars` in `infra/www/pbrand/`—review before running.

CI / CD APP
----------------------------
Continous Integration and Continous Delivery CD/CI works in this way:

- The git workflow I chose was [feature-branch](https://mergify.com/blog/feature-branch-workflow-a-practical-guide-for-git)

- For every PR opened there is an automated process [html-lint](/.github/workflows/html-lint.yml) in order to be able to close the PR, I configured that on the repos settings (PR has this job as validator).

- To deploy new changes on the default environment, we need to create a new 'release' branch with the version number (release/0.0.1) and modify the package.json file with the app version to keep the version of the application.

- When the PR is close, there is another github action that will start on every push on main branch, It will check if the new commit has a tag version, which means there is a new release that has been closed on main branch. If there is not any tag, the deploy process do not start.

CI / CD INFRA
----------------------------
TODO