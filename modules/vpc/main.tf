

# installer un loadbalancer , et dns name au lieu de eip

resource "aws_vpc" "prod" {
    
    cidr_block = var.vpc_cidr
    tags = {
        name = "projet1"
    }   
} 

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.public_cidr

   tags = { name = "public_subnet"}
}


# not still use 

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.prod.id
  cidr_block = var.private_cidr

  tags = { name = "private_subnet"}
  
}


resource "aws_internet_gateway" "igw" {
   
    vpc_id = aws_vpc.prod.id
    tags = { name = "igw"}
  
}

resource "aws_internet_gateway_attachment" "igw" { 

    vpc_id = aws_vpc.prod.id
    internet_gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table" "rt" {
  
  vpc_id = aws_vpc.prod.id

  route = {
  
  cidr_block = "0.0.0.0/0"
  internet_gateway_id = aws_internet_gateway.id
           
  }


  tags = { name = "route table p1"}
}

resource "aws_route_table_association" "name" {

    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.public
  
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

  description = "allow imcp"
  from_port = -1
  to_port = -1
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "imcp"

}

egress {

  from_port = -1
  to_port = -1
  protocol = -1
  cidr_blocks =  ["0.0.0.0/0"]


}
  
}
 