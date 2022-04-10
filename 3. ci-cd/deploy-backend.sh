#!/bin/bash
export AWS_PAGER="" # disable default aws cli pager
SERVICE_NAME="devops-service"
TASK_FAMILY="devops-app-task"
CLUSTER_NAME="devops-cluster"

# Create a new task definition for this build
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" backend-deployment-config.json > deployment-config-v_${BUILD_NUMBER}.json
aws ecs register-task-definition --family devops-app-task --cli-input-json file://backend-deployment-config-v_${BUILD_NUMBER}.json --no-paginate

# Update the service with the new task definition and desired count
TASK_REVISION=`aws ecs describe-task-definition --task-definition devops-app-task --no-paginate | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/\([0-9]*\),\([0-9]*\)/\1\2/g'`
#DESIRED_COUNT=`aws ecs describe-services --cluster ${CLUSTER_NAME} --services ${SERVICE_NAME} --no-paginate | egrep "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
# if [ ${DESIRED_COUNT} = "0" ]; then
#     DESIRED_COUNT="1"
# fi

#aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count 3
aws ecs update-service --cluster ${CLUSTER_NAME} --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count 3 --no-paginate