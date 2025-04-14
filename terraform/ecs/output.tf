output "subnet_id" {
  value = aws_subnet.my_subnet.id
}


output "ecs_cluster_name" {
  value = aws_ecs_cluster.my_ecs_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.my_ecs_service.name
}
