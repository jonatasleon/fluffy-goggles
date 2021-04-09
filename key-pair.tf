resource "aws_key_pair" "tf_key" {
  key_name   = var.key_name_primary
  public_key = file("terraform-aws.pub")
}

resource "aws_key_pair" "tf_key_secondary" {
  provider   = aws.secondary
  key_name   = var.key_name_secondary
  public_key = file("terraform-aws.pub")
}
