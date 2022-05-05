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
          host = self.public_ip
          user = "ec2-user"
          private_key = file("./btk-terraform.pem")
        #   public_key = file("${path.module}/id_rsa.pub")
        }
    }
}

