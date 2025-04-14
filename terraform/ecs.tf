
module "ecs" {
  source = "./ecs"
  aws_region          = var.aws_region
  security_group_ids   = [module.public_sg.security_group_id] 
  public_subnet_ids  = module.vpc.public_subnet_ids
  vpc_id =  module.vpc.vpc_id
  subnet_name         = var.subnet_name
  subnet_cidr_block   = var.subnet_cidr_block
  availability_zone   = var.availability_zone
  security_group_name =  module.public_sg.security_group_id #var.security_group_name
  ecs_cluster_name    = var.ecs_cluster_name
  task_family_name    = var.task_family_name
  task_cpu            = var.task_cpu
  task_memory         = var.task_memory
  execution_role_arn  = var.execution_role_arn
  container_name      = var.container_name
  container_cpu       = var.container_cpu
  container_memory    = var.container_memory
  container_port      = var.container_port
  ecs_service_name    = var.ecs_service_name
  desired_count       = var.desired_count
  image_tag           = var.image_tag
  repo_url            = var.repo_url
  public_subnets      = var.public_subnets

}


