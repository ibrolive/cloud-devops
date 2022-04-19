aws_region= "us-east-1"

# ECS vars
ecs_task_execution_role_name= "myEcsTaskExecutionRole"
az_count          = "2"
app_image         = "nginxdemos/hello" # ibrolive/devops-demo:react-springboot-image-frontend
app_port          = 80
app_port_frontend = 81
app_port_backend  = 82
app_count         = 3
health_check_path = "/login"
task_cpu          = "3072"
task_memory       = "6144"
container_cpu     = "1024"
container_memory  = "2048"

# MySQL DB vars
db_name           = "mysqldb"
db_username       = "user1"
db_password       = "password"
db_port           = 3306
db_instance_class = "db.t2.micro"
