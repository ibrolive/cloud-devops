@echo off
echo Destroying AMI...

set REGION=us-east-1
aws ec2 describe-images --filters "Name=name,Values=custom-jenkins-ami" --query "Images[*].[ImageId]" --output text --region %REGION% > temp
set /p TEMPVAR=<temp
more temp
del temp
aws ec2 deregister-image --image-id %TEMPVAR% --region %REGION%

aws ec2 describe-snapshots --filters "Name=tag:Environment,Values=devops-demo" --query "Snapshots[*].{ID:SnapshotId}" --output text --region %REGION% > temp
set /p TEMPVAR=<temp
del temp
aws ec2 delete-snapshot --snapshot-id %TEMPVAR% --region %REGION%

echo Destroy AMI complete
pause