pipeline {
    agent any
    tools {
        maven 'maven3.9'
        jdk 'jdk17'
    }
    environment {
        DockerHubID = 'amaldeep98'
        ImageName = 'memory-monster'
        HelmRepoName = 'memory-monster'
    }
    stages {
        stage('Git-checkout') {
            steps {
                git 'https://github.com/Amaldeep98/Memory-Monster.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage ('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage ('docker-login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                }
            }

        }
        stage('docker-build') {
            steps {
                sh 'docker build -t $DockerHubID/$ImageName:latest .'
                sh 'docker tag $DockerHubID/$ImageName:latest $DockerHubID/$ImageName:$BUILD_NUMBER'
            }
        }
        stage('docker-push and cleanup') {
            steps {
                sh 'docker push $DockerHubID/$ImageName:latest'
                sh 'docker push $DockerHubID/$ImageName:$BUILD_NUMBER'
                sh 'docker rmi $DockerHubID/$ImageName:latest'
                sh 'docker rmi $DockerHubID/$ImageName:$BUILD_NUMBER' 
            }
        }
        stage('helm-tag-update') {
            steps {
                sh "sed -i 's/tag: .*/tag: $BUILD_NUMBER/' ./helm/values.yaml"
                sh "sed -i 's/version: .*/version: $BUILD_NUMBER/' ./helm/Chart.yaml"
            }
        }
        stage ('ecr-login') {
            steps {
                sh 'aws ecr-public get-login-password --region us-east-1 \
                    | helm registry login --username AWS --password-stdin public.ecr.aws'
            }
        }
        stage ('helm-repo-create') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', 
                  credentialsId: 'aws-creds']]) {
                    sh '''
                        aws ecr-public describe-repositories --repository-names $HelmRepoName --region us-east-1 > /dev/null 2>&1 \
                        || aws ecr-public create-repository --repository-name $HelmRepoName --region us-east-1
                    '''
                }
            }
        }
        stage('helm-push') {
            steps {
                withCredentials([string(credentialsId: 'aws-public-alias', variable: 'AWS_ALIAS')]) {
                    sh  '''
                        set -e
                        helm package ./helm
                        helm push ./$HelmRepoName-*.tgz oci://public.ecr.aws/$AWS_ALIAS
                        rm -rf *.tgz
                    '''
                }
                
            }
        }
        stage('Trigger Deploy Job') {
            steps {
                build job: 'Memory-monster-deploy', parameters: [
                    string(name: 'BUILD_NUMBER_ID', value: "${env.BUILD_NUMBER}")
                ]
            }
        }
  
    }
    post {
        always {
            sh 'docker logout'
        }

    }

}