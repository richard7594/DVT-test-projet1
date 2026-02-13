resource "aws_key_pair" "key" {

    key_name = "richou"
    public_key = file("~/.ssh/id_rsa.pub")

  
}




resource "aws_instance" "instance" {

 ami = var.ami
 instance_type = var.type
 key_name = aws_key_pair.key.key_name
 vpc_security_group_ids = [sg_id]  
 subnet_id = var.public_subnet
 
 associate_public_ip_address = true

 
 tags = { name = var.name}
  
}