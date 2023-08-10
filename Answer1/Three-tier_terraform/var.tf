variable "name" {}
variable "additional_tags" {
  type = map(string)
  default = {
    "Terraform"     = "true"
    "Organization"  = "india"
    "Environment"   = "DEV"
    "Crindiated_by" = "Mohit.sharma"
    "Approved_by"   = "Ritika"
  }
}


#########Network##########
variable "vpc_cidr" {}
variable "public_sn_count" {}
variable "private_sn_count" {}
variable "access_ip" {}
variable "cluster_Ports" {}
variable "node_Ports" {}

###################Compute##############
variable "jenkins_instance_type" {}
variable "ami_jenkins" {}
variable "jenkins_Ports" {}

##########EKS Cluster Input Variables###########
variable "cluster_name" {}
variable "cluster_service_ipv4_cidr" {}
variable "cluster_version" {}
variable "disk_size" {}
variable "instance_types" {}
variable "max_size" {}
variable "min_size" {}
variable "desired_size" {}

##########Redis Cluster###########
variable "node_type" {}
variable "num_cache_nodes" {}

###########RDS-Cluster###########
variable "db_instance_class" {}
variable "db_engine_version" {}
variable "db_identifier" {}
variable "db_port" {}
variable "db_name" {
  type = string
}
variable "dbuser" {
  type      = string
  sensitive = true
}
variable "dbpassword" {
  type      = string
  sensitive = true
}