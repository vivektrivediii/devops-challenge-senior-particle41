aws_region         = "us-east-1"

vpc_name        = "vivek-poc-vpc"
vpc_cidr        = "10.1.0.0/16"
vpc_azs         = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets  = ["10.1.0.0/20", "10.1.16.0/20", "10.1.48.0/20"]
private_subnets = ["10.1.128.0/19", "10.1.96.0/19", "10.1.64.0/19"]

vpc_tags = {
  Environment = "development"
  Terraform   = "True"
}

bucket_names = [ "vivek-poc-tf"]


### ecs

subnet_name         = "devops-ecs-subnet"
subnet_cidr_block   = "172.31.240.0/24"
availability_zone   = "us-east-1a"
security_group_name = "vivek-poc-public-security-group"
ecs_cluster_name    = "devops-ecs-cluster"
task_family_name    = "devops-task-family"
task_cpu            = 1024
task_memory         = 2048
execution_role_arn  = "arn:aws:iam::165446266030:role/ecsTaskExecutionRole"
container_name      = "devops-apps-container"
container_cpu       = 1024
container_memory    = 2048
container_port      = 5000
ecs_service_name    = "devops-apps-service"
desired_count       = 1
image_tag           = "latest"
repo_url            = "vivek6899/simple-time-service"
