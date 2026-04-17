# cloud-lab

Personal cloud engineering laboratory built on AWS using Terraform.  
Infrastructure as Code from day one. No manual clicks. No exceptions.

---

## Projects

### 01 — Static Website with CloudFront CDN

A production-grade static website served over HTTPS via CloudFront CDN,  
fully provisioned with Terraform and automatically deployed via GitHub Actions.

**Live URL:** https://d1vfx1vo0bwn93.cloudfront.net

#### Architecture

```
User
 └─► CloudFront (HTTPS, edge caching, cache invalidation on deploy)
      └─► S3 (static origin, public read policy)
```

#### Stack

| Tool | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| AWS S3 | Static file storage + website hosting |
| AWS CloudFront | CDN + HTTPS termination |
| AWS DynamoDB | Terraform state locking |
| GitHub Actions | CI/CD pipeline |

#### Infrastructure

- S3 bucket configured for static website hosting with public read policy
- CloudFront distribution with `redirect-to-https` viewer protocol policy
- Cache-Control headers set on upload (`max-age=300`)
- CloudFront cache invalidation triggered automatically on every deploy
- Terraform remote state stored on S3 with DynamoDB locking and encryption

#### CI/CD Pipeline

Every push to `master` that modifies `index.html` triggers the following pipeline:

```
push to master
 └─► GitHub Actions
      ├─► Configure AWS credentials (via repository secrets)
      ├─► Upload index.html to S3 (with cache-control headers)
      └─► Invalidate CloudFront cache (/* paths)
```

No manual intervention required after initial provisioning.

#### How to replicate

**Prerequisites:** AWS CLI configured, Terraform >= 1.0, an S3 bucket for remote state.

```bash
# Clone the repository
git clone https://github.com/gyalecta/cloud-lab.git
cd cloud-lab/01-primo-terraform

# Initialise Terraform (pulls remote state from S3)
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply
```

**Required GitHub Secrets:**

| Secret | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | IAM user access key |
| `AWS_SECRET_ACCESS_KEY` | IAM user secret key |
| `CLOUDFRONT_DISTRIBUTION_ID` | CloudFront distribution ID |

#### Cost

Estimated monthly cost at low traffic: **< $0.10**  
(S3 storage + CloudFront free tier covers 1TB transfer/month for the first 12 months)

---

## Infrastructure conventions

- All resources tagged with `Environment` and `Name`
- Remote Terraform state on S3 with versioning enabled
- State locking via DynamoDB (`PAY_PER_REQUEST` billing)
- IAM principle of least privilege — dedicated deploy user, no root credentials
- `force_destroy = true` on lab buckets only — never in production
- Billing alerts configured at $1 threshold

---

## Roadmap

- [x] Tier 1 — Static website: S3 + CloudFront + Terraform + CI/CD
- [ ] Tier 2 — Serverless URL shortener: Lambda + API Gateway + DynamoDB
- [ ] Tier 3 — Multi-tier app on EKS with GitOps: Kubernetes + ArgoCD + Prometheus

---

## Certifications in progress

- [ ] AWS Cloud Practitioner (CLF-C02)
- [ ] AWS Solutions Architect Associate (SAA-C03)
- [ ] AWS Developer Associate (DVA-C02)
- [ ] AWS DevOps Engineer Professional (DOP-C02)
- [ ] IELTS C1

---

## Author

**Domenico Avino** — Cloud Engineer in training  
Building toward a Cloud Engineer role in Northern Europe.

[GitHub](https://github.com/gyalecta)