resource "aws_instance" "sayone_server" { 
  ami  = var.ami
  instance_type = var.instance_type
  count    = var.ec2_count
  key_name = var.key_name
  tags = var.tags
  subnet_id = module.vpc.subnetid
  vpc_security_group_ids = [module.SG.sgid]
  iam_instance_profile = module.IAM.terraform_role
   
 
  user_data = <<-EOF
            #!/bin/bash
            sudo apt-get update && sudo apt-get upgrade -y
            sudo su - ubuntu
            sudo apt-get install nginx -y
            sudo systemctl enable nginx
            sudo systemctl start nginx
            sudo bash -c 'echo hello world > /var/www/html/index.html'

             EOF

 
    

    
}
resource "aws_eip" "sayone-eip" {
  vpc        = true
  instance = aws_instance.sayone_server[0].id
  depends_on = [module.vpc.gatewayid]
}

module "vpc" {
 source  = "./module/vpc"
 availability_zone = var.availability_zone
 availability_zone2 = var.availability_zone2
 tags  = var.tags
 }
module "SG" {
  source  = "./module/sg"
  sg_ingress_rules = var.sg_ingress_rules
 
  a_vpc_id            =  module.vpc.vpcid
  availability_zone = var.availability_zone
   
}
module "S3" {
  source = "./module/s3"
  bucket = var.bucket
  cloudfront_origin_arn = module.cloudfront.cloudfront_identity
  suffix = var.suffix
  key    = var.key
  ec2_role_arn = module.IAM.iam-role
}

module "IAM" {
    source = "./module/iam-user"
}

module "ELB" {
    source = "./module/elb"
    lb_sg  = module.SG.sgid3
    lb_subnet = module.vpc.subnetid
    lb_subnet2 = module.vpc.subnetid2
    lb_vpc     = module.vpc.vpcid
    lb_instance = aws_instance.sayone_server[0].id
    #acm_certificate = module.acm.acm_cert
    name  = var.name
    load_balancer_type = var.load_balancer_type
}
module "cloudfront" {
    source = "./module/cloudfront"
    s3_domain = module.S3.domain
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    viewer_protocol_policy = var.viewer_protocol_policy 
    origin_id   = var.origin_id    
    #acm_certificate = module.acm2.acm_cert2
} 

module "elasticsearch" {
     source = "./module/elasticsearch"
     elasticsearch_version = var.elasticsearch_version
     instance_count        = var.instance_count
     volume_size           = var.volume_size

}
module "redis" {
   source = "./module/redis"   
   availability_zone = var.availability_zone
   redis_sg          = module.SG.sgid4
   sb1      = module.vpc.subnetid2
   sb2      = module.vpc.subnetid
   redis_cluster_id = var.redis_cluster_id
   redis_engine = var.redis_engine
   redis_node_type = var.redis_node_type
   redis_num_cache_nodes = var.redis_num_cache_nodes
   redis_parameter_group_name =var.redis_parameter_group_name
   redis_engine_version = var.redis_engine_version
   redis_port           = var.redis_port
}
module "autoscaling" {
   source = "./module/autoscaling"
   subnet = module.vpc.subnetid
   subnet2 = module.vpc.subnetid2
   instance_id2 = aws_instance.sayone_server[0].id
   sg1 = module.SG.sgid
   key_name = var.key_name 
   alb1 = module.ELB.elb_arn
   wait_30_seconds = time_sleep.wait_30_seconds

}
module "cloudwatch" {
  source = "./module/cloudwatch"
  asg_name = module.autoscaling.asg_name
  asg_policy1 = module.autoscaling.asg_policy1
  asg_policy2 = module.autoscaling.asg_policy2
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_instance.sayone_server]

  create_duration = "300s"
}
module "cloudfront-static" {
    source = "./module/cloudfront-static"
    s3_domain = module.s3-static.domain
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    viewer_protocol_policy = var.viewer_protocol_policy 
    origin_id_static = var.origin_id_static   
    #acm_certificate = module.acm2.acm_cert2
} 

module "s3-static" {
  source = "./module/s3-static"
  bucket1 = var.bucket1
  cloudfront_origin_arn = module.cloudfront-static.cloudfront_identity
  suffix = var.suffix
  key    = var.key
}
 module "rds" {
   source = "./module/rds"
   security-groupid = module.SG.sgid2
   subnetid      =  module.vpc.subnetid
   subnetid2	 =  module.vpc.subnetid2
   allocated_storage    = var.allocated_storage
   engine               = var.engine
   engine_version       = var.engine_version
   instance_class       = var.instance_class
   name                 = var.name
   username             = var.username
   password             = var.password
   parameter_group_name = var.parameter_group_name
   skip_final_snapshot  = var.skip_final_snapshot
   identifier           = var.identifier
}

