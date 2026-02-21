

# installer un loadbalancer , et dns Name au lieu de eip

resource "aws_vpc" "prod" {
    
    cidr_block = var.vpc_cidr
    tags = {
        Name = "projet1"
    }   
} 

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.public_cidr

   tags = { Name = "public_subnet"}
}

resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.public_cidr2
  availability_zone = "eu-west-1b"

   tags = { Name = "public_subnet2"}
}


# not still use 

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.private_cidr
 

  tags = { Name = "private_subnet"}
  
}


resource "aws_internet_gateway" "igw" {
   
    vpc_id = aws_vpc.prod.id
    tags = { Name = "igw"}
  
}

# resource "aws_internet_gateway_attachment" "igw" { 

#     vpc_id = aws_vpc.prod.id
#     internet_gateway_id = aws_internet_gateway.igw.id
# }

resource "aws_route_table" "rt" {
  
  vpc_id = aws_vpc.prod.id

  route {
  
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
           
  }


  tags = { Name = "route table p1"}
}

resource "aws_route_table_association" "Name" {

    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.public.id
  
}

resource "aws_route_table_association" "Name1" {

    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.public2.id
  
}

resource "aws_security_group" "sg" {
  
vpc_id = aws_vpc.prod.id

ingress {

  from_port = 22
  to_port = 22
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "tcp"

}

ingress {

  from_port = 80
  to_port = 80
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "tcp"
  

}

ingress {

  description = "allow imcp"
  from_port = -1
  to_port = -1
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "icmp"

}

egress {

  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks =  ["0.0.0.0/0"]


}
  

  tags = {
    Name = "Richou-sg"
  }
}
 