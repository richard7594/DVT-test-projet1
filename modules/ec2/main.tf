resource "aws_key_pair" "key" {

    key_name = "richou"
    public_key = file("~/.ssh/id_rsa.pub")

  
}

resource "aws_iam_role" "ec2_role" {

    name = "ec2_role"

    assume_role_policy = jsonencode({

        Version = "2012-10-17"
        Statement = [
        {

           Action = "sts:AssumeRole"
           Effect = "allow"
           Sid = ""

           Principal = {  Service = "ec2.amazonaws.com" }

        },]  })


    tags = {
       description = "role s3"
       Name = "s3"

    } 
  
}

resource "aws_iam_role_policy" "s3" {

   name = "test"
   role = aws_iam_role.ec2_role.id
   policy = jsonencode({

            Version = "2012-10-17"
            Statement = [{

              Action = [ 
                   "s3:Get*",
                   "s3:List*"
              ]

              Effect = "Allow"
              Resource = "*"

            },]

            }) 


  
}

resource "aws_iam_instance_profile" "ec2_profile" {

    name = var.name
    role = aws_iam_role.ec2_role.name
  
}


resource "aws_instance" "instance" {

 ami = var.ami
 instance_type = var.type
 key_name = aws_key_pair.key.key_name
#  key_name = "richou"
 vpc_security_group_ids = [var.sg_id]  
 subnet_id = var.public_subnet
 
 associate_public_ip_address = true
 iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
 
 
 tags = { Name = var.name
          description = var.name
 }
  
}

