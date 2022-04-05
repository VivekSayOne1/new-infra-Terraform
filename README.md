# new-infra-Terraform
new-infra-Terraform


In this Terraform config we used some resources that helps smooth working of an application


main.tf :- used as a root module , every modules that we calls in here

var.tf :- vaiables defined in this file

terraform.tfvars  :- if we need to modifiy an resources spec came here and edit it


Modules :- In this folder contain several resources that we needed, In here we declared all the resources




Resources that we declared in the module folder :-

autoscaling  cloudfront  cloudfront-static  cloudwatch  elasticsearch  elb  iam-user  rds  redis  s3  s3-static  sg  vpc
