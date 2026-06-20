
module "dynamoDB" {
  source = "./modules/dynamoDB" 
}

module "lambda" {
  source = "./modules/lambda"
  runtime = var.runtime  
  depends_on = [ module.dynamoDB ]
}

output "api_url" {
  value = module.lambda.api_url
}