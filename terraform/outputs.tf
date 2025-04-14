output "subnet_id" {
  description = "The ID of the created subnet"
  value       = module.ecs.subnet_id
}


output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = module.ecs.ecs_service_name
}
