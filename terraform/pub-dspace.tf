provider "aws" {
  profile  = "default"
  region   = "us-west-2"
}

resource "aws_instance" "pub-ds-api-dev" {
  ami      = "ami-0e472933a1395e172"
  instance_type = "t3.medium"
  security_groups = ["SSH from bastion and UCOP VPN", "pub-ds-dev"]
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

resource "aws_eip" "pub-ds-api-dev" {
  instance = aws_instance.pub-ds-api-dev.id
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.pub-ds-api-dev.id
  allocation_id = aws_eip.pub-ds-api-dev.id
}

