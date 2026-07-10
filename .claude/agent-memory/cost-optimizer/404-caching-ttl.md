---
name: cloudfront-404-caching-ttl
description: 404 error caching TTL set to 0 causes unnecessary origin requests for missing assets
metadata:
  type: project
---

The CloudFront distribution sets error_caching_min_ttl = 0 for 404 responses, meaning every 404 request goes to the S3 origin immediately instead of being cached at CloudFront edges.

**Why:** Without caching 404s, bots and scanners probing for common paths (e.g., /admin, /wp-admin) generate repeated origin requests, incurring S3 GET charges and increasing origin load.

**How to apply:** Set error_caching_min_ttl to at least 300 (5 minutes) in the custom_error_response block. Even 1-hour caching (3600) is reasonable for a static site. This reduces origin requests by ~90% for 404s.
