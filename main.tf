terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

provider "aws" {
  alias   = "secondary"
  region  = "us-east-2"
}

resource "aws_instance" "dev" {
  count         = 2
  ami           = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.tf_key.key_name

  vpc_security_group_ids = [
    aws_security_group.acesso_ssh.id,
    aws_security_group.acesso_https.id
  ]

  tags = {
    Name = "dev${count.index}"
  }

  depends_on = [
    aws_s3_bucket.dev_bucket
  ]
}

resource "aws_instance" "dev_secondary" {
  provider      = aws.secondary
  count         = 3
  ami           = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.tf_key_secondary.key_name

  vpc_security_group_ids = [
    aws_security_group.acesso_ssh_secondary.id,
  ]

  tags = {
    Name = "dev${count.index}"
  }

  depends_on = [
    aws_dynamodb_table.dynamodb-table
  ]
}

resource "aws_s3_bucket" "dev_bucket" {
  bucket = "terraform-bucket-dev"
  acl    = "private"

  tags = {
    Name = "dev-bucket-terraform"
  }
}

resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}
