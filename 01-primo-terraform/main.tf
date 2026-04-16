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
        Name = "Il mio primo bucket"
        Environment = "Lab"
    }
}