resource "aws_security_group" "terraform-security-gp" {
   
   name        = "Terraform-sg" 
   description = "Allow web inbound traffic"
   vpc_id = var.a_vpc_id   


  
  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks 
      description = ingress.value.description
    }
  }

ingress {
    description      = "postgres"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups = [aws_security_group.terraform-security-gp2.id]
    
  }

egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}
resource "aws_security_group" "terraform-security-gp2" {

   name        = "Terraform-sg2"
   description = "Allow web inbound traffic"
   vpc_id = var.a_vpc_id

ingress {
    description      = "postgres"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.terraform-security-gp.id]
    
  }

  
 
egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}

resource "aws_security_group" "terraform-security-gp3" {

   name        = "Terraform-sg3"
   description = "Allow web inbound traffic"
   vpc_id = var.a_vpc_id

ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }
ingress {
    description      = "HTTPS"
    from_port        = 443  
    to_port          = 443 
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }




egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}
resource "aws_security_group" "terraform-security-redis" {

   name        = "Terraform-sg-redis"
   description = "Allow web inbound traffic"
   vpc_id = var.a_vpc_id

ingress {
    description      = "Redis"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    security_groups = [aws_security_group.terraform-security-gp.id]
    
  }

  
 
egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}