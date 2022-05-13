locals {
  name_file_code = "default_code.zip"
}

data "aws_iam_policy_document" "policy_for_lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy_for_lambda.json
}

data "archive_file" "python_lambda_package" {
  type        = "zip"
  source_file = "${path.module}/code/lambda_function.py"
  output_path = local.name_file_code
}


resource "aws_lambda_function" "test_lambda" {
  filename = local.name_file_code

  function_name = "poc_lambda_iac"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
  runtime          = "python3.8"
  environment {
    variables = {
      teste = "teste"
    }
  }
}

