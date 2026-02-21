data "aws_iam_policy_document" "role" {

    statement {
      
      actions = "sts:AssumeRole"
      principals {
        type = "Service"
        identifiers = [ "lambda.amazonaws.com" ]
      }

    }
  
}

data "aws_iam_policy_document" "rds_policy"{

   statement {
     
      actions = ["rds:*"]
      effect = "Allow"
      resources = [ "*" ]
      
   }


}

resource "aws_iam_policy" "rds_lamda" {
  policy = data.aws_iam_policy_document.rds_policy.json
  
}


resource "aws_iam_role" "lambda_role" {
 name = "lambda"
 assume_role_policy = data.aws_iam_policy_document.role.json   
  
}

resource "aws_iam_policy_attachment" "pa" {
  name = "lambda_basic"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicDurableExecutionRolePolicy"
  roles = [ ws_iam_policy.rds_lamda.name]
}
resource "aws_iam_policy_attachment" "p_rds" {
    name = "rds policy"
    policy_arn = aws_iam_policy.rds_lamda.arn
    roles = [aws_iam_policy.rds_lamda.name]
}


data "archive_file" "arch" {
  type = "zip"
  source_file = 
  output_path = 

}

resource "aws_lambda_function" "name" {
    function_name = "richou"
    role = aws_iam_role.lambda_role.arn
    runtime = "python3.10"
    handler = 
    filename = data.archive_file.arch.output_path
    

  
}