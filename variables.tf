#variable "api_gateway_id" {
#  description = "O ID do API Gateway"
#  type        = string
#}
variable "api_gateway_execution_arn" {
  description = "ARN do API Gateway para permissões do Lambda"
  type        = string
}

variable "jwt_secret" {
  description = "JWT Secret Key"
  type        = string
}

variable "bucket" {
  description = "Bucket Tf state"
  type        = string
}
