# Cloud Lab — Domenico Avino

Personal cloud engineering lab built on AWS using Terraform.

## Projects

### 01 — Static website with CloudFront CDN
Provisioning of an S3 static website behind CloudFront CDN with forced HTTPS.

**Stack:** Terraform · AWS S3 · AWS CloudFront

**Architecture:** S3 (origin) → CloudFront (CDN + HTTPS) → User

**Live URL:** https://d1vfx1vo0bwn93.cloudfront.net

## Architecture

User → CloudFront (HTTPS) → S3 (origin)

## CI/CD

Every push to `master` that modifies `index.html` triggers 
a GitHub Actions workflow that:
1. Uploads the file to S3
2. Invalidates the CloudFront cache automatically

## Goals
Building toward AWS Solutions Architect Associate certification
and a Cloud Engineer role in Northern Europe.