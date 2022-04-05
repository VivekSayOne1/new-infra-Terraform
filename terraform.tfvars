    access_key        =  
    secret_key        = 
    ami               = 
    key_name          = 

    instance_type     = "t2.micro"
    region            =   "ap-south-1"
    availability_zone = "ap-south-1b"
    availability_zone2 = "ap-south-1a"
    tags              = { 
      Name            ="sayone-terraform"
}
  #RDS
  allocated_storage    = "20"
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  name                 = "sayoneterraform"
  username             = "Vivek1"
  password             = "Admin1234"
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true
  identifier           = "sayone-rds"
  #publicly_accessible  = true
   
  #s3
   bucket = "sayoneterraform123"
   bucket1 = "static-sayone-terraform12"
   suffix = "index.html"
   key    = "error.html"
  #elb
   load_balancer_type = "application"

   #cloudfront
   allowed_methods  = ["GET", "HEAD"]
   cached_methods   = ["GET", "HEAD"]
   viewer_protocol_policy = "redirect-to-https"
   origin_id  = "mys3"
   origin_id_static = "static_mys3"

   #elastic_search
    elasticsearch_version = "7.8"
    instance_count        = 1
    volume_size           = 10


    #Redis
    redis_cluster_id           = "cluster-redis"
    redis_engine               = "redis"
    redis_node_type            = "cache.t2.micro"
    redis_num_cache_nodes      =  1
    redis_parameter_group_name = "default.redis6.x"
    redis_engine_version       = "6.x"
    redis_port                 = "6379"
 
sg_ingress_rules = {
  "HTTP" = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  },
  "HTTPS" = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  },
  "SSH" = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

}
