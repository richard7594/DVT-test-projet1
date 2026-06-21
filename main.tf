
module "dynamoDB" {
  source = "./modules/dynamoDB"
}

module "lambda" {
  source     = "./modules/lambda"
  runtime    = var.runtime
  depends_on = [module.dynamoDB]
}

output "GET_api_url" {
  value = "curl ${module.lambda.api_url}/dev/note?id=2&tournoir=world_cup"
}

output "POST_api_url" {
  value = "curl -X POST ${module.lambda.api_url}/dev/insert "
}