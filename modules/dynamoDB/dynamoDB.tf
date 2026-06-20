locals {
  items_to_insert = {
    "item1" = { Id = "1", tournoir = "world_cup", Nom = "richou",   Prenom = "varice" }
    "item2" = { Id = "2", tournoir = "world_cup", Nom = "richard", Prenom = "varice" }
    "item3" = { Id = "1", tournoir = "LDC",       Nom = "richou",   Prenom = "varice" }
  }
}


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
  for_each = local.items_to_insert

  table_name = aws_dynamodb_table.dynamodb-table.name
  hash_key   = aws_dynamodb_table.dynamodb-table.hash_key
  range_key  = aws_dynamodb_table.dynamodb-table.range_key

  # jsonencode formate automatiquement les types DynamoDB (S, N, etc.) en JSON valide
  item = jsonencode({
    "Id"       = { "N" = each.value.Id }
    "tournoir" = { "S" = each.value.tournoir }
    "Nom"      = { "S" = each.value.Nom }
    "Prenom"   = { "S" = each.value.Prenom }
  })
}