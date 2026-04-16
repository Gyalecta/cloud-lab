terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "eu-west-1"
}

resource "aws_s3_bucket" "primo_bucket" {
    bucket = "domenico-cloud-lab-2026"

    tags = {
        Name = "Sito statico"
        Environment = "Lab"
    }
}

resource "aws_s3_bucket_website_configuration" "sito" {
    bucket = aws_s3_bucket.primo_bucket.id

    index_document {
        suffix = "index.html"
    }
}

resource "aws_s3_bucket_public_access_block" "sito" {
    bucket = aws_s3_bucket.primo_bucket.id

    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}