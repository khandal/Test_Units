name = "india"
##################VPC###############
vpc_cidr         = "10.0.0.0/16"
public_sn_count  = 3
private_sn_count = 3
access_ip        = ["1.6.151.77/32","180.151.230.178/32"]
jenkins_Ports    = [22, 8080, 443, 80, 5432, 6379]
cluster_Ports    = [22, 443, 80, 5432, 6379]
node_Ports       = [22, 443, 80, 5432, 6379]

###################jenkins###############
jenkins_instance_type = "t3.large"
ami_jenkins           = "ami-0989fb15ce71ba39e"

#########EKS Cluster Input Variables
cluster_name              = "eksdemo"
cluster_version           = "1.27"
cluster_service_ipv4_cidr = "172.20.0.0/16"
instance_types            = "t3.medium"
disk_size                 = 50
min_size                  = 1
max_size                  = 1
desired_size              = 1


##########Redis Cluster###########
num_cache_nodes = 1
node_type       = "cache.t4g.medium"

###########Database Variable##########
db_name           = "indiadb"
dbuser            = "india"
dbpassword        = "5oEsTwlR8QdU7dk"
db_instance_class = "db.t3.medium"
db_engine_version = "15.3"
db_identifier     = "india-dev-db"
db_port           = "5432"