data "archive_file" "arch" {
  type = "zip"
  source_file = "${path.root}/lambda/lambda.py"
  output_path = "${path.root}/lambda/lambda.zip"

}
data "aws_dynamodb_table" "table" {
  name = "Note"
}

resource "aws_lambda_function" "lambda" {
    function_name = "note"
    role = aws_iam_role.lambda_role.arn
    runtime = var.runtime
    handler = "lambda.lambda_handler"
    filename = data.archive_file.arch.output_path
  environment {
     variables = {     
      Name="${data.aws_dynamodb_table.table.name}"
     }
  }
}


