resource "aws_security_group" "acesso_ssh" {
  name        = "acesso_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from my current IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs
  }

  tags = {
    Name = "acesso_ssh"
  }
}

resource "aws_security_group" "acesso_https" {
  name        = "acesso_https"
  description = "Allow HTTP/HTTPS inbound traffic"

  ingress {
    description = "HTTP from my current IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cdirs
  }

  ingress {
    description = "HTTPS from my current IP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cdirs
  }

  tags = {
    Name = "acesso_https"
  }
}

resource "aws_security_group" "acesso_ssh_secondary" {
  provider    = aws.secondary
  name        = "acesso_ssh-secondary"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH from my current IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs
  }

  tags = {
    Name = "acesso_ssh"
  }
}

resource "aws_security_group" "acesso_https_secondary" {
  provider    = aws.secondary
  name        = "acesso_https-secondary"
  description = "Allow HTTP/HTTPS inbound traffic"

  ingress {
    description = "HTTP from my current IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cdirs
  }

  ingress {
    description = "HTTPS from my current IP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cdirs
  }

  tags = {
    Name = "acesso_https"
  }
}
