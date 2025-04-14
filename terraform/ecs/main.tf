# VPC
data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_name
  }
}

# ECS Cluster
resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = var.ecs_cluster_name
}

# ECS Task Definition
resource "aws_ecs_task_definition" "my_task_definition" {
  family            = var.task_family_name
  cpu               = var.task_cpu
  memory            = var.task_memory
  network_mode      = "awsvpc"
  execution_role_arn = var.execution_role_arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([{
    name      = var.container_name
    image     = "${var.repo_url}:${var.image_tag}"
    cpu       = var.container_cpu
    memory    = var.container_memory
    essential = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
  }])
}

# ECS Service
resource "aws_ecs_service" "my_ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.my_ecs_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.public_subnet_ids
    security_groups = var.security_group_ids
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.http]

}



###alb

# ALB
resource "aws_lb" "my_alb" {
  name               = "vivek-poc-alb"
  internal           = false
  load_balancer_type = "application"  
  security_groups    = var.security_group_ids
  subnets            =  var.public_subnet_ids #["subnet-066db781870ed7502", "subnet-00b7e3360be1afe6f"]  


  tags = {
    Name = "vivek-poc-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "my_target_group" {
  name     = "vivek-poc-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   =  var.vpc_id  
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "vivek-poc-tg"
  }
}

# Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

