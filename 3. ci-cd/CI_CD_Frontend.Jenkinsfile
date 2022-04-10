def docker_image_registry = 'registry-1.docker.io/v1'
def docker_image_repository = 'ibrolive/devops-demo'
def docker_image_tag = 'react-springboot-image-frontend'
pipeline { 
agent any 
    stages { 
        stage ('Prerequisites') {
            steps {
                sh '''
                    #sudo yum install -y docker java-1.8.0-openjdk-devel maven
                    #sudo curl --output /var/lib/jenkins/apache-maven-3.8.1-bin.tar.gz https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz
                    #tar -xvf /var/lib/jenkins/apache-maven-3.8.1-bin.tar.gz
                    #docker --help
                    #service docker restart #might not be necessary
                '''
            }
        }
        stage ('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/ibrolive/react-and-spring-data-rest.git'
            }
        }
        stage ('Build') { 
            steps {
                sh '''
                    chmod -R 777 .
                    chmod +x mvnw
                    ./mvnw clean verify
                '''
            }
        }
        stage ('Test') { 
            steps {
                // skipping tests because maven version 3.1.0 is required and only 3.0.5 is available on amazon linux noarch
                sh './mvnw test #-Dmaven.test.failure.ignore=true -DskipTests -Dmaven.test.skip=true'
            }
        }
        stage ('Build Image') { 
            steps {
                sh "docker build . -t ${docker_image_repository}:${docker_image_tag}"
            }
        }
        stage ('Push Image') { 
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'registry',
                usernameVariable: 'REGISTRY_USER',
                passwordVariable: 'REGISTRY_PASSWORD']]) {
                    sh """
                        docker login ${docker_image_registry} -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD}
                        docker push ${docker_image_repository}:${docker_image_tag}
                    """
                }
            }
        }
        stage ('Deploy') {
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'aws_cli_credential',
                usernameVariable: 'AWS_ACCESS_KEY_ID',
                passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    echo 'Deploying application'
                    sh """
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                        export AWS_DEFAULT_REGION=us-east-1
                        
                        ./deploy-frontend.sh
                    """
                }
            } 
        }
    }           
 }