---
name: s3-versioning-portfolio-site
description: S3 versioning enabled on portfolio static site incurs storage costs for version history
metadata:
  type: feedback
---

S3 versioning is enabled on the portfolio site bucket, but for a static HTML/CSS website without dynamic content updates, this adds unnecessary storage costs.

**Why:** Versioning creates multiple copies of every object. For a static site where files are rarely updated, this bloats storage costs without benefit.

**How to apply:** Disable versioning in terraform/main.tf since this is a static portfolio site. If version history becomes important later, it can be re-enabled, but currently it's just overhead.
