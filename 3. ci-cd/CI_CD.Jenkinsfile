def dockerhub_repository = 'ibrolive/devops-demo'
pipeline { 
agent any 
    stages { 
        stage ('Prerequisites') {
            steps {
                sh '''
                    sudo yum install -y docker java-1.8.0-openjdk-devel maven
                    sudo curl --output /var/lib/jenkins/apache-maven-3.8.1-bin.tar.gz https://downloads.apache.org/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz
                    tar -xvf /var/lib/jenkins/apache-maven-3.8.1-bin.tar.gz
                    docker --help
                    #service docker restart #might not be necessary
                '''
            }
        }
        stage ('Checkout') {
            steps {
                git branch: 'master',
                    //credentialsId: 'git-credential', // needs to be added to Jenkins (as code)
                    url: 'https://github.com/ibrolive/react-and-springboot-ci-cd-iac.git'
            }
        }
        stage ('Build') { 
            steps {
                sh '''
                    cd react-and-spring-data-rest
                    sudo chmod -R 777 .
                    chmod +x mvnw
                    ./mvnw clean verify
                '''
            }
        }
        stage ('Test') { 
            steps {
                // skipping tests because maven version 3.1.0 is required and only 3.0.5 is available on amazon linux noarch
                sh '''
                    cd react-and-spring-data-rest
                    /var/lib/jenkins/workspace/apache-maven-3.8.1/bin/mvn test #-Dmaven.test.failure.ignore=true -DskipTests -Dmaven.test.skip=true
                '''
            }
        }
        stage ('Build Image') { 
            steps {
                sh """
                    cd react-and-spring-data-rest
                    sudo docker build . -t ${dockerhub_repository}:react-springboot-image
                """
            }
        }
        stage ('Push Image') { 
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'registry',
                usernameVariable: 'REGISTRY_USER',
                passwordVariable: 'REGISTRY_PASSWORD']]) {
                    sh """
                        sudo docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD}
                        sudo docker push ${dockerhub_repository}:react-springboot-image
                    """
                }
            }
        }
        stage ('Deploy DEV') {
            steps {
                echo 'Deploying to DEV environment'
            } 
        }
        stage ('Verify DEV') {
            steps {
                sh 'curl -v -u greg:turnquist dev.server.com:8080/api/employees/1'
            }
        }
        stage ('Deploy STAGING') {
            steps {
                echo 'Deploying to STAGING environment'
            }
        }
        stage ('Verify STAGING') {
            steps {
                sh 'curl -v -u greg:turnquist staging.server.com:8080/api/employees/1'
            }
        }
        stage ('Deploy PRODUCTION') {
            steps {
                echo 'Deploying to PRODUCTION environment'
            }
        }
        stage ('Verify PRODUCTION') {
            steps {
                sh 'curl -v -u greg:turnquist production.server.com:8080/api/employees/1'
            }
        }
    }           
 }