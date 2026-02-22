resource "aws_dynamodb_table" "Note" {
  name = "Note"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key     = "nb"

  
  attribute {
    name = "nb"
    type = "S"
  } 

  
}