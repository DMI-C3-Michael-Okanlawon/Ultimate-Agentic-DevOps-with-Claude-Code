---
name: cloudfront-priceclass-optimization
description: CloudFront PriceClass_200 is suboptimal for low-traffic portfolio sites; PriceClass_100 sufficient
metadata:
  type: project
---

The CloudFront distribution uses PriceClass_200, which covers ~200 global edge locations. For a portfolio website with likely moderate/low traffic and regional audience, PriceClass_100 (covering ~100 edge locations in high-traffic regions) is sufficient and costs approximately 33% less.

**Why:** PriceClass_200 targets broader geographic distribution, but a portfolio site doesn't require worldwide edge coverage.

**How to apply:** Change price_class from "PriceClass_200" to "PriceClass_100" in terraform/main.tf. Estimated savings: ~$39-50 per year depending on traffic volume.
