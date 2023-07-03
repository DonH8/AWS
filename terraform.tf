terraform {
  required_version = ">= 1.0.0"
  
  backend "s3" {
    bucket         = "bucketperdonin"
    key            = "terraformdon.tfstate"
    region         = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}

# EC2 instance for Bastion host
resource "aws_instance" "bastion_host" {
  ami           = "ami-09d460305982fdfcf"    # Replace with the ID of the desired AMI
  instance_type = "t3.micro"    # Replace with the desired instance type (e.g., t2.micro)
  key_name      = "key-pair-don"    # Replace with the name of your key pair

  subnet_id     ="subnet-0346b6f822801bb8e"   # Replace with the ID of your public subnet

  vpc_security_group_ids = ["sg-0326bbfb22e2d6ce6"]   # Reference the security group ID created for the Bastion host
}
# Security group for Bastion host

resource "aws_db_instance" "database_donmysql" {
  identifier            = "donmysql1"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  storage_type          = "gp2"
  username              = "don"
  password              = "donbaba1"
  db_subnet_group_name =  "subnet-don"
  publicly_accessible   = false
  vpc_security_group_ids = ["sg-0e1bb23d2fa9f5071"]
  multi_az                  = false
  backup_retention_period   = 7
  skip_final_snapshot       = true
}
