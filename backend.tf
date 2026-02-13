terraform {

   backend "S3" {

      bucket = "richou.projet11"
      key = "richou.projet1/terraform.tfstate"
      region = var.region
      use_lockfile = true
      encrypt = true
     
   }  
}