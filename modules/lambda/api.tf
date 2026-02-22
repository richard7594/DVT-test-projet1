resource "aws_apigatewayv2_api" "lamda" {

    name = "lambda-api"
    protocol_type = "HTTP"   
    
}

resource "aws_apigatewayv2_integration" "itg" {
   api_id = aws_apigatewayv2_api.lamda.id
   integration_type = "AWS_PROXY"
   integration_uri = aws_lambda_function.lambda.invoke_arn
   

}

resource "aws_apigatewayv2_route" "name" {
    
    api_id = aws_apigatewayv2_api.lamda.id
    route_key = "GET /note"  
    target = "integrations/${aws_apigatewayv2_integration.itg.id}"

}

resource "aws_apigatewayv2_stage" "name" {
  api_id = aws_apigatewayv2_api.lamda.id
  name = "dev"
  auto_deploy = true
  
}