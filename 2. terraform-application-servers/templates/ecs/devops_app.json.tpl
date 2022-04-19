{
  "containerDefinitions": [
    {
      "name": "devops-app",
      "image": "${app_image}",
      "cpu": ${fargate_cpu},
      "memory": ${fargate_memory},
      "networkMode": "awsvpc",
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/devops-app",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "ecs"
          }
      },
      "portMappings": [
        {
          "containerPort": ${app_port},
          "hostPort": ${app_port}
        }
      ]
    },
    {
      "name": "devops-app-frontend",
      "image": "${app_image}",
      "cpu": ${fargate_cpu},
      "memory": ${fargate_memory},
      "networkMode": "awsvpc",
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/devops-app",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "ecs"
          }
      },
      "portMappings": [
        {
          "containerPort": ${app_port_frontend},
          "hostPort": ${app_port_frontend}
        }
      ]
    },
    {
      "name": "devops-app-backend",
      "image": "${app_image}",
      "cpu": ${fargate_cpu},
      "memory": ${fargate_memory},
      "networkMode": "awsvpc",
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/devops-app",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "ecs"
          }
      },
      "portMappings": [
        {
          "containerPort": ${app_port_backend},
          "hostPort": ${app_port_backend}
        }
      ]
    }
  ]
  "cpu": "3072",
  "memory": "6144"
}