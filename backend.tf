terraform {

   backend "s3" {

      bucket = "richou.projet11"
      key = "richou.projet1/terraform.tfstate"
      region = "eu-west-1"
      use_lockfile = true
      encrypt = true
     
   }  
}