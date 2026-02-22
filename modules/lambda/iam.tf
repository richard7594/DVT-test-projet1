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

resource "aws_iam_policy" "rds_lamda" {
  policy = data.aws_iam_policy_document.dynamo_db_po.json
  
}


resource "aws_iam_role" "lambda_role" {
 name = "lambda"
 assume_role_policy = data.aws_iam_policy_document.role.json   
  
}

resource "aws_iam_role_policy_attachment" "pa" {

  role =  aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
 
}
resource "aws_iam_role_policy_attachment" "p_rds" {
    policy_arn = aws_iam_policy.rds_lamda.arn
     role =  aws_iam_role.lambda_role.name
}

