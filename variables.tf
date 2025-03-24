#variable "api_gateway_id" {
#  description = "O ID do API Gateway"
#  type        = string
#}
variable "api_gateway_execution_arn" {
  description = "ARN do API Gateway para permissões do Lambda"
  type        = string
}

variable "local_name" {
  description = "Concatenation of product name, release name and environment"
  type        = string
}
