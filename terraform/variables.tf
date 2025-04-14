variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_azs" {
  description = "The availability zones for the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
  default     = {}
}

variable "bucket_names" {
  description = "A list of names for the S3 buckets to be created."
  type        = list(string)
}

variable "acl" {
  description = "The canned ACL to apply."
  type        = string
  default     = "private"
}

variable "force_destroy" {
  description = "Whether to allow the buckets to be destroyed forcefully."
  type        = bool
  default     = false
}

variable "versioning" {
  description = "Enable versioning on the buckets."
  type        = bool
  default     = false
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use."
  type        = string
  default     = "AES256"
}

variable "kms_master_key_id" {
  description = "The AWS KMS master key ID to use for default encryption."
  type        = string
  default     = null
}

##ECS vars

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
