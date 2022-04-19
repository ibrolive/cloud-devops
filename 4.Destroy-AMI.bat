@echo off
echo Destroying AMI...

set REGION=us-east-1
set AWS_PROFILE=default
aws ec2 describe-images --filters "Name=tag:Name,Values=jenkins-server" --query "Images[*].[ImageId]" --output text --region %REGION% > temp
set /p TEMPVAR=<temp
more temp
del temp
aws ec2 deregister-image --image-id %TEMPVAR% --region %REGION%

echo AMI deregistered

aws ec2 describe-snapshots --filters "Name=tag:Environment,Values=jenkins-server" --query "Snapshots[*].{ID:SnapshotId}" --output text --region %REGION% > temp
set /p TEMPVAR=<temp
del temp
aws ec2 delete-snapshot --snapshot-id %TEMPVAR% --region %REGION%

echo AMI snapshot deleted

echo Destroy AMI complete
pause