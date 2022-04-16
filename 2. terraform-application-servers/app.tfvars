aws_region= "us-east-1"

# ECS vars
ecs_task_execution_role_name= "myEcsTaskExecutionRole"
az_count          = "2"
app_image         = "nginxdemos/hello" # ibrolive/devops-demo:react-springboot-image-frontend
app_port          = 80
app_count         = 3
health_check_path = "/login"
fargate_cpu       = "1024"
fargate_memory    = "2048"

# MySQL DB vars
db_name           = "mysql-db"
db_username       = "user1"
db_password       = "passwords"
db_port           = 3306
db_instance_class = "db.t2.micro"
