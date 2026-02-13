module "vpc" {
    source = "modules/vpc"

    vpc_cidr = ["10.0.0.0/24"]
    public_cidr = ["10.0.0.0/16"]
    private_cidr = ["10.1.0.0/16"]
}

module "ec2" {
    source = "modules/ec2"

    ami = "ami-0744568de95a42bd6"
    type = "t3.micro"
    name = "richou_p1"
    public_subnet =  module.vpc.public_subnet
    sg_id = module.vpc.sg_id
  
}