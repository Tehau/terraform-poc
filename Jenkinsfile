pipeline {
    agent any
    stages {
        stage('Initialize') {
            steps {
                script {
                    def dockerHome = tool 'docker'
                    def terraformHome = tool name: 'terraform'
                    env.PATH = "${dockerHome}/bin:${terraformHome}:${env.PATH}"
                }
                sh 'terraform -version'
                sh 'docker --version'
            }
        }
        stage('Checkout Terraform file') {
            steps {
              checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init -backend=true -input-false'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan -input=false'
                script {
                  timeout(time: 10, unit: 'MINUTES') {
                    input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
                  }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -lock=false -input=false tfplan'
            }
        }
    }
}