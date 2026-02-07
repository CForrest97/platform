output "s3_bucket_id" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.tofu_state.id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.tofu_state.arn
}

output "dynamodb_table_id" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.tofu_locks.id
}

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.tofu_locks.arn
}
