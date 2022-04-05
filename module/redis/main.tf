resource "aws_elasticache_cluster" "redis_cluster" {
  cluster_id           = var.redis_cluster_id
  engine               = var.redis_engine
  node_type            = var.redis_node_type
  num_cache_nodes      = var.redis_num_cache_nodes
  parameter_group_name = var.redis_parameter_group_name
  engine_version       = var.redis_engine_version
  port                 = var.redis_port
  availability_zone    = var.availability_zone
  security_group_ids   = [ var.redis_sg ]
  subnet_group_name    = aws_elasticache_subnet_group.redis_sub.name
  
}

resource "aws_elasticache_subnet_group" "redis_sub" {
  name  = "redis-sub-grp"
  subnet_ids = [ var.sb1,var.sb2]  
}
