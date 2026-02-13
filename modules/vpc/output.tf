output "vpc_id" {
   value = aws_vpc.prod.id 
}
output "sg_id" {
  value = aws_security_group.sg.id
}
