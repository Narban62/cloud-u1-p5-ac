#Proveedor AWs
provider "aws" {
  region = "us-east-1"
}

#Creamos el Security Group
resource "aws_security_group" "mi-sg" {
  name = "mi-security-group-terraform"
  description = "Security group para instancia de Terraform"
  vpc_id = "vpc-098881630d1255eba"
  #regla de entrada para ssh y salida para http
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#declaracion de recursos aws, todo lo que quiera aprovisionar desde tf se llama recurso
resource "aws_instance" "mi_instancia" {
  ami = "ami-0c230065b91270bc6"
  #familia
  instance_type = "t2.micro"
  key_name      = "mi-primera-llave-ac"
  tags = {
    Name = "MiInstanciaTerraform"
  }
  vpc_security_group_ids = [ aws_security_group.mi-sg.id ] #Asignamos el security group a la instancia
}
