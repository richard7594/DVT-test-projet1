resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "Note"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Id"
  range_key = "tournoir"
  

  attribute {
    name = "Id"
    type = "N"
  }

  attribute {
    name = "tournoir"
    type = "S"
  }

  attribute {
    name = "Nom"
    type = "S"
  }
  attribute {
    name = "Prenom"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "example" {
  table_name = aws_dynamodb_table.dynamodb-table.name
  hash_key   = aws_dynamodb_table.dynamodb-table.hash_key
  range_key = aws_dynamodb_table.dynamodb-table.range_key

  item = <<ITEM
{
  "Id": {"N": "1"},
  "tournoir": {"S": "world_cup"},
  "Nom": {"S": "richou"},
  "Prenom": {"S": "varice"},
}
{
"Id": {"N": "2"},
  "tournoir": {"S": "world_cup"},
  "Nom": {"S": "richard"},
  "Prenom": {"S": "varice"},
}
{
"Id": {"N": "1"},
  "tournoir": {"S": "LDC"},
  "Nom": {"S": "richou"},
  "Prenom": {"S": "varice"},
}
ITEM
}