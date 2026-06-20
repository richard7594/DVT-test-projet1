data "aws_iam_policy_document" "role" {

    statement {
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = [ "lambda.amazonaws.com" ]
      }

    }
  
}

data "aws_iam_policy_document" "dynamo_db_po"{
   statement {
      
      effect = "Allow"
      actions = ["dynamodb:*"]
      resources = [ "*" ]
      
   }
}


resource "aws_iam_role" "lambda_role" {
 name = "lambda_role"
 assume_role_policy = data.aws_iam_policy_document.role.json   
  
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_permission" {
  role =  aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
 
}
resource "aws_iam_role_policy" "dynamo_db_permission" {
  role =  aws_iam_role.lambda_role.name 
  policy = data.aws_iam_policy_document.dynamo_db_po.json  
}

