resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_apigatewayv2_api" "lamda" {
  name          = "lambda-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "itg" {
  api_id           = aws_apigatewayv2_api.lamda.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "rt" {
  api_id    = aws_apigatewayv2_api.lamda.id
  route_key = "GET /note"
  target    = "integrations/${aws_apigatewayv2_integration.itg.id}"
}

resource "aws_apigatewayv2_stage" "dev" {
  api_id      = aws_apigatewayv2_api.lamda.id
  name        = "dev"
  auto_deploy = true
}

