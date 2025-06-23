resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = "arn:aws:iam::058264063478:role/devport_lambda_exec"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_apigatewayv2_api" "api" {
  name          = "devport-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}