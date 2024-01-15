# ------------------
# EC2
# ------------------
resource "aws_instance" "pgadmin" {
  ami = data.aws_ami.ubuntu_20_04.id
  instance_type = "t2.micro"
  availability_zone = var.az_a
  vpc_security_group_ids = [aws_security_group.pgadmin.id]
  subnet_id = module.vpc.public_subnets[0]
  key_name = aws_key_pair.pgadmin.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-${var.environment}-pgadmin"
  }
}

resource "tls_private_key" "rsa_2048" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "pgadmin" {
  key_name   = "${var.project_name}-${var.environment}-pgadmin"
  public_key = tls_private_key.rsa_2048.public_key_openssh
}

data "aws_ami" "ubuntu_20_04" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

output "pgadmin_private_key" {
  value = tls_private_key.rsa_2048.private_key_pem
  sensitive = true
}

output "aws_ec2_public_ip" {
  value = aws_instance.pgadmin.public_ip
}
