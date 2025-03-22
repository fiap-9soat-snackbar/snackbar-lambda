resource "aws_lambda_layer_version" "jwt_layer" {
  layer_name          = "jwt-layer"
  compatible_runtimes = ["python3.9"]
  filename            = "modules/lambda-authorizer/build/lambda_layer.zip"
}

resource "aws_lambda_function" "authorizer" {
  function_name    = "${var.local_name}-lambda-authorizer"
  role             = "arn:aws:iam::953430082388:role/LabRole" // Precisa atualizar com o ID da conta AWS
  handler          = "authorizer.lambda_handler"
  runtime          = "python3.9"
  filename         = "modules/lambda-authorizer/build/authorizer.zip"
  source_code_hash = filebase64sha256("modules/lambda-authorizer/build/authorizer.zip")
  memory_size      = 128
  timeout          = 5

  layers = [aws_lambda_layer_version.jwt_layer.arn]

  environment {
    variables = {
      JWT_SECRET  = "3cfa76ef14937c1c0ea519f8fc057a80fcd04a7420f8e8bcd0a7567c272e007b"
      PYTHONPATH  = "/opt/python"
    }
  }
}

resource "aws_lambda_permission" "api_gateway_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.authorizer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_gateway_execution_arn}/*/*"
}
