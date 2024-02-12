provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "samanvay-flask" {
  ami           = "ami-03f4878755434977f" 
  instance_type = "t2.medium"               
  key_name      = "flask-api"    

  tags = {
    Name = "samanvay-flask"
  }

  security_groups = ["samanvay-flask-sg"]

  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/flask-api/flask-api.pem")
    host        = self.public_ip
  }

  
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo docker run -d -p 5000:5000 samanvay0712/samanvay_flask_api" 
    ]
  }
}

resource "aws_security_group" "samanvay-flask-sg" {
  name        = "samanvay-flask-sg"
  description = "Security group for Samanvay Flask application"

 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
