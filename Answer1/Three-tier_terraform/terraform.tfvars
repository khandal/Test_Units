name = "india"
##################VPC###############
vpc_cidr         = "10.0.0.0/16"
public_sn_count  = 2
private_sn_count = 2
access_ip        = ["0.0.0.0/0"]
jenkins_Ports    = [22, 8080, 443, 80, 5432, 6379]
cluster_Ports    = [22, 8080, 443, 80, 5432, 6379]
node_Ports       = [22, 8080, 443, 80, 5432, 6379]

###################jenkins###############
jenkins_instance_type = "t2.micro"
ami_jenkins           = "ami-053b0d53c279acc90"

#########EKS Cluster Input Variables
cluster_name              = "eksdemo"
cluster_version           = "1.27"
cluster_service_ipv4_cidr = "172.20.0.0/16"
instance_types            = t3.medium
disk_size                 = 20
min_size                  = 1
max_size                  = 1
desired_size              = 1


##########Redis Cluster###########
num_cache_nodes = 1
node_type       = "db.t4g.small"

###########Database Variable##########
db_name           = "indiadb"
dbuser            = "india"
dbpassword        = "naPair9ieNoh"
db_instance_class = "db.t3.medium"
db_engine_version = "15.3"
db_identifier     = "india-dev-db"
db_port           = "5432"