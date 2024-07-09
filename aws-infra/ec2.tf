data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "app" {
  count                     = 2
  ami                       = data.aws_ami.amazon_linux.id
  instance_type             = "t2.micro"
  subnet_id                 = element(aws_subnet.private.*.id, count.index)
  security_groups           = [aws_security_group.app_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "AppInstance${count.index}"
  }


  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io
    systemctl start docker
    systemctl enable docker
    docker run -d -p 3000:3000 antonyjebinraj/my-app
  EOF
}
