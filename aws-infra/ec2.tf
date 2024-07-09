resource "aws_instance" "app" {
  count                     = 2
  ami                       = "ami-0a0e5d9c7acc336f1"
  instance_type             = "t2.micro"
  subnet_id                 = element(aws_subnet.private.*.id, count.index)
  security_groups           = [aws_security_group.app_sg.id]
  associate_public_ip_address = true
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
