module "vpc" {
    source = "./modules/vpc" # chemin relatif

    vpc_cidr = "10.0.0.0/16"
    public_cidr = "10.0.0.0/24"
    private_cidr = "10.0.1.0/24"
}

module "ec2" {
    source = "./modules/ec2"

    ami = "ami-0c5d3777e994cd6cc"
    type = "t3.micro"
    name = "richou_p1"
    public_subnet =  module.vpc.public_sub
    sg_id = module.vpc.sg_id
  
}