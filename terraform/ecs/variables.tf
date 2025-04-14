variable "aws_region" {
  description = "AWS region for the resources"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "task_family_name" {
  description = "Family name for the ECS task definition"
  type        = string
}

variable "task_cpu" {
  description = "CPU units for the task definition"
  type        = string
}

variable "task_memory" {
  description = "Memory for the task definition"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM execution role ARN for the task"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_cpu" {
  description = "CPU units for the container"
  type        = number
}

variable "container_memory" {
  description = "Memory for the container"
  type        = number
}

variable "container_port" {
  description = "Port on which the container will run"
  type        = number
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "Number of desired instances of the ECS service"
  type        = number
}

variable "image_tag" {
  description = "Tag for the frontend Docker image in ECR"
  type        = string
}

variable "repo_url" {
  description = "URL of the frontend ECR repository"
  type        = string
}


variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "security_group_ids" {
  type = list(string)
}
variable "vpc_id" {
  description = "The VPC ID for the ECS resources"
  type        = string
}
variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}
