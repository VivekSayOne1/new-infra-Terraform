provider "aws" {
 secret_key = var.secret_key
 access_key = var.access_key
 region     = var.region
 
}
variable "secret_key" {
  description = "secret_key for aws"
}
variable "access_key" {
  description = "Access_key for aws"
}
variable "ami" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
 
}
variable "key_name" {
  description = "aws key_name"
}
variable "region" {
  description = "aws instance region"
}

variable "availability_zone" {
  description = "aws availability_zone"
}

variable "availability_zone2" {
   description = "new"
}

variable "instance_type" {
  description = "aws instance type"
}

variable "tags" {
description = "terraform instance tag name"
type = map
}

variable "sg_ingress_rules" {
  description = "Ingress security group rules"
  type        = map
}
variable "ec2_count" {
  type = number
  default = "1"
}
variable "allocated_storage" {
  description = "allocated space for rds"
   type = number

}
variable "engine" {
     description = "rds engine specification"
}
variable "engine_version" {
   description = " rds engine version specification"
}
variable "instance_class" {
   description = " rds engine instance_class specification"
}
variable "name" {
    description = "rds name specification"
}
variable "username" {
    description = "rds db username specification"
}
variable "password" {
    description = "rds db instance password specification"
}
variable "parameter_group_name" {
    description = "rds db engine parameter_group_name specification"
}
variable "skip_final_snapshot" {
    description = "rds db engine snapshot"
}
variable "bucket" {
  description = "aws s3 bucket-name"
}
variable "load_balancer_type" {
    description = "specify load-balancer type"
}
variable "suffix" {
   description = "add suffix value"
} 
variable "key" {
   description = "add key value"
}
variable "allowed_methods" {
  description = "allowed methods we can define here"
}
variable "cached_methods" {
  description = "cached_methods we can define here"
}
variable "viewer_protocol_policy" {
  description = "viewer_protocol_policy we can define here"
}
variable "elasticsearch_version" {
    description = "define elasticsearch version"
}
variable "instance_count" {
    description = "define instance count"
}
variable "volume_size" {
    description = "define volume_size"
}
variable "origin_id" {
  description = "added the origin name"
}
variable "bucket1" {
  description = "aws s3 bucket-name"
}
variable "origin_id_static" {
  description = "added the origin name"
}

variable "identifier" {
    description = "rds db engine identifier name"
}
variable "redis_cluster_id" {
      description = "redis cluster id"
}
variable "redis_engine" {
      description = "redis_engine"
}
variable "redis_node_type" {
      description = "redis_nodetype"
}
variable "redis_num_cache_nodes" {
      description = "redis_num_cache_nodes"
}
variable "redis_parameter_group_name" {
      description = "redis_parameter_group_name"
}
variable "redis_engine_version" {
      description = "redis_engine_version"
}
variable "redis_port" {
      description = "redis_port"
}