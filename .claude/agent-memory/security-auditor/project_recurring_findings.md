---
name: project-recurring-findings
description: Specific security gaps found in the 2026-07-10 audit of terraform/ — check these first on re-audit to see what's fixed
metadata:
  type: project
---

First full audit (2026-07-10) of `terraform/main.tf` etc. found these gaps. On the next audit, check each one first to see if it was remediated — don't re-derive from scratch:

1. **No `.gitignore`** in repo root; `terraform/terraform.tfstate` and `.terraform/` provider binaries exist in the working tree with no exclusion rule. State isn't shown as untracked in `git status`, suggesting it may already be committed to history.
2. **No `aws_s3_bucket_server_side_encryption_configuration`** resource for `aws_s3_bucket.site` — relies on AWS's implicit default SSE-S3 rather than an explicit, auditable resource.
3. **`aws_s3_bucket_policy.site`** has only an `Allow` statement for CloudFront OAC — no explicit `Deny` for `aws:SecureTransport = false` to enforce TLS-only access at the bucket-policy layer.
4. **No `aws_s3_bucket_logging`** on the site bucket — no access log trail.
5. **No CloudFront `logging_config` block** — no CDN access logs.
6. **No `response_headers_policy`** attached to the CloudFront default cache behavior — no CSP/X-Frame-Options/HSTS/X-Content-Type-Options enforced at the edge.
7. **S3 bucket name embeds the raw AWS account ID** (`${data.aws_caller_identity.current.account_id}`) — minor recon/info-disclosure concern.
8. **Local Terraform backend** (backend.tf commented out) — state not encrypted-at-rest in a remote backend, no locking.
9. **`viewer_certificate.cloudfront_default_certificate = true`** with no custom domain — can't pin `minimum_protocol_version`, so legacy TLS is implicitly allowed. Only relevant if/when `domain_name` variable actually gets wired up.

**Why this matters:** These were all flagged in the same pass, so a re-audit should specifically verify remediation of these 9 items rather than treating the whole module as unreviewed. See [[project-terraform-baseline]] for what infra exists.

**How to apply:** When re-auditing, grep for `server_side_encryption`, `aws_s3_bucket_logging`, `logging_config`, `response_headers_policy`, `SecureTransport`, and check for a `.gitignore` — if still absent, these findings still stand; report them at the same severity as before unless the user says otherwise.
