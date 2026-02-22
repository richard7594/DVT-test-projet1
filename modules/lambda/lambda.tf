


data "archive_file" "arch" {
  type = "zip"
  source_file = "${path.root}/lambda.py"
  output_path = "${path.root}/lambda.zip"

}

resource "aws_lambda_function" "lambda" {
    function_name = "richou"
    role = aws_iam_role.lambda_role.arn
    runtime = var.run_time
    handler = "lambda.lambda_handler"
    filename = data.archive_file.arch.output_path
 
  environment {
    
     variables = {     
      Name="Note"
     }
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
}

