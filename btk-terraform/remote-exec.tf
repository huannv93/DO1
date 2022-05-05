variable "sg_ports" {
    type = list(number)
    description = "This is list port allow in SG"
    default = [ 80, 22, 443 ]
}
/*
resource "aws_security_group" "allow-tls" {
    name = "btk-sg"
    description = "Ingress for Web"

    dynamic "ingress" {
        for_each = var.sg_ports
        iterator = port 

        content {
            from_port = port.value
            to_port   = port.value
            protocol  = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        for_each = var.sg_ports
        iterator = port 

        content {
            from_port = port.value
            to_port   = port.value
            protocol  = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
}

resource "aws_instance" "myec2" {
    ami = "ami-0c2b8ca1dad447f8a"
    instance_type = "t2.micro"
    key_name = "btk-terraform"

    provisioner "remote-exec" {
      inline = [
          "sudo amazon-linux-extras install -y nginx1.12",
          "sudo systemctl start nginx"
      ]

      connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("${path.module}/btk-terraform.pem")
        # private_key = file("./btk-terraform.pem")
        host = self.public_ip
      }
    }
}

output "eip" {
  value = aws_instance.myec2.public_ip
}
*/