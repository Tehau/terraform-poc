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
                sh 'ls'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
                script {
                  timeout(time: 10, unit: 'MINUTES') {
                    input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
                  }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply'
            }
        }
    }
}