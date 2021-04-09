output "ips" {
  value = aws_instance.dev.*.public_ip
}

output "arn" {
  value = aws_dynamodb_table.dynamodb-table.arn
}
