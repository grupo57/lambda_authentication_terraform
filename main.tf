provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
}

# Função Lambda
resource "aws_lambda_function" "auth_function" {
  function_name    = "lambda_authentication_${var.environment}"
  handler          = "br.com.techchallenge.lambda.creator.LambdaJwtCreatorHandler::handleRequest"
  runtime          = "java11"
  role             = aws_iam_role.lambda_exec_role.arn
  filename         = "LambdaJwtCreator-6.0.0.jar"  # Especifica o arquivo JAR
  source_code_hash = filebase64sha256("LambdaJwtCreator-6.0.0.jar")

  environment {
    variables = {
      ENV = var.environment
    }
  }
}

# Role IAM para a função Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role_${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Anexar política à role IAM
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}