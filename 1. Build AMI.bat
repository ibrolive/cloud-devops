@echo off
cd ./_0.AMI
set PACKER_LOG=10
set PACKER_LOG_PATH=./packer.log
echo starting AMI build
packer build ami.json
cd ..
pause