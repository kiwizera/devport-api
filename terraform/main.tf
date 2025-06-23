resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = "arn:aws:iam::058264063478:role/devport_lambda_exec"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_apigatewayv2_api" "devport" {
  name          = "DevPortAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.devport.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.get_developers.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}


######################## GET /developers ########################
resource "aws_apigatewayv2_route" "get_developers" {
  api_id    = aws_apigatewayv2_api.devport.id
  route_key = "GET /developers"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}
resource "aws_lambda_function" "get_developers" {
  function_name = "getDevelopers"
  role          = "arn:aws:iam::058264063478:role/devport_lambda_exec"
  handler       = "handler.handler"
  runtime       = "python3.12"
  filename      = "../backend/lambda/get_developers/get_developers.zip"
  source_code_hash = filebase64sha256("../backend/lambda/get_developers/get_developers.zip")
}



resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.devport.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_developers.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.devport.execution_arn}/*/*"
}