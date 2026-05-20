erraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# S3 bucket for model storage
resource "aws_s3_bucket" "model_storage" {
  bucket = "predictive-aiops-model-storage-2025"

  tags = {
    Project = "predictive-aiops-platform"
  }
}

# EC2 instance — free tier
resource "aws_instance" "demo_app" {
  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"

  tags = {
    Name        = "predictive-aiops-demo"
    Environment = "dev"
    Project     = "predictive-aiops-platform"
  }
}

# EventBridge rule — every 60 seconds
resource "aws_cloudwatch_event_rule" "anomaly_trigger" {
  name                = "anomaly-detection-trigger"
  schedule_expression = "rate(1 minute)"

  tags = {
    Project = "predictive-aiops-platform"
  }
}