resource "aws_lambda_layer_version" "jwt_layer" {
  layer_name          = "jwt-layer"
  compatible_runtimes = ["python3.9"]
  filename            = "build/lambda_layer.zip"
}

resource "aws_lambda_function" "authorizer" {
  function_name    = "${data.terraform_remote_state.global.outputs.project_name}-lambda-authorizer"
  role             = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
  handler          = "authorizer.lambda_handler"
  runtime          = "python3.9"
  filename         = "build/authorizer.zip"
  source_code_hash = filebase64sha256("build/authorizer.zip")
  memory_size      = 128
  timeout          = 5

  layers = [aws_lambda_layer_version.jwt_layer.arn]

  environment {
    variables = {
      JWT_SECRET  = "${var.jwt_secret}"
      PYTHONPATH  = "/opt/python"
    }
  }
}

#resource "aws_lambda_permission" "api_gateway_lambda" {
#  action        = "lambda:InvokeFunction"
#  function_name = aws_lambda_function.authorizer.function_name
#  principal     = "apigateway.amazonaws.com"
#  source_arn    = "${var.api_gateway_execution_arn}/*/*"
#}
