resource "aws_db_instance" "name" {

  instance_class = var.db_type
  db_name = "richou_db"
  engine = var.engine
  engine_version = var.ver
  username = var.username
  password = var.pw
  allocated_storage = 2
  

}