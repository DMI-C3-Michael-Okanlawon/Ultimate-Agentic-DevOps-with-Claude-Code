---
name: project-terraform-baseline
description: Current shape of the portfolio-site Terraform config (S3+CloudFront+OAC), what exists and what doesn't yet
metadata:
  type: project
---

As of 2026-07-10, `terraform/` contains only 5 files: `main.tf`, `providers.tf`, `variables.tf`, `outputs.tf`, `backend.tf`. Single AWS S3 + CloudFront (OAC, not OAI) static site setup for a JS-free HTML/CSS portfolio (per root CLAUDE.md). No IAM roles, no OIDC trust policies, no GitHub Actions workflow files exist yet anywhere in the repo (verified via grep for oidc/assume_role/iam/github — only matched unrelated skill/agent docs).

- `backend.tf` — S3 remote backend block is present but fully commented out; state is local (`terraform/terraform.tfstate`). Comment block documents the intended bootstrap order (apply locally first, then create state bucket + `terraform-locks` DynamoDB table, then uncomment and migrate).
- `variables.tf` declares `domain_name` but it is **not referenced anywhere** in `main.tf` — no `aliases` block, no ACM certificate, no ` viewer_certificate` custom cert. CloudFront currently only serves off the default `*.cloudfront.net` cert (`cloudfront_default_certificate = true`).
- S3 bucket name is `${project_name}-${environment}-${data.aws_caller_identity.current.account_id}` — deliberately embeds the raw AWS account ID for uniqueness.
- No `.gitignore` exists in the repo root at all. `terraform/terraform.tfstate` and `terraform/.terraform/` (provider binaries) exist on disk in the working tree.

**Why this matters:** Future audits of this repo should diff against this baseline — if IAM/OIDC resources, a custom domain, or a remote backend get added, re-check the checklist items that were previously "not applicable" (OIDC trust scoping, IAM least privilege, ACM/TLS min version). See [[project-recurring-findings]] for the specific gaps found in the first audit pass.

**How to apply:** Before re-auditing, re-run the grep for oidc/assume_role/iam/github and re-check `variables.tf` for `domain_name` usage to see if these have changed since this snapshot.
