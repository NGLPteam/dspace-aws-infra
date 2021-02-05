provider "aws" {
  profile  = "default"
  region   = "us-west-2"
}

resource "aws_instance" "pub-ds-api-dev" {
  ami      = "ami-0e472933a1395e172"
  instance_type = "t3.medium"
  security_groups = ["SSH from bastion and UCOP VPN"]
  key_name = "hpottinger-keypair"
  tags = {
    Name = "pub-ds-api"
    Environment = "dev"
    Project = "dspace"
  }
}

resource "aws_instance" "pub-ds-client-dev" {
  ami      = "ami-0e472933a1395e172"
  instance_type = "t3.micro"
  security_groups = ["SSH from bastion and UCOP VPN"]
  key_name = "hpottinger-keypair"
  tags = {
    Name = "pub-ds-client"
    Environment = "dev"
    Project = "dspace"
  }
}
