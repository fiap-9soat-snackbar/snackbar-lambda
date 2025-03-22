output "lambda_authorizer_invoke_arn" {
  description = "Invoke ARN do Lambda Authorizer"
  value       = aws_lambda_function.authorizer.invoke_arn
}