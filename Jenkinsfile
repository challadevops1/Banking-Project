pipeline {
  agent any
     tools {
       maven 'M2_HOME'
           }
  stages {
    stage('Git Checkout') {
      steps {
        echo 'This stage is to clone the repo from github'
        git branch: 'main', url: 'https://github.com/challadevops1/Banking-Project.git'
                          }
            }
    stage('Create Package') {
      steps {
        echo 'This stage will compile, test, package my application'
        sh 'mvn package'
                          }
            }
    stage('Generate Test Report') {
      steps {
        echo 'This stage generate Test report using TestNG'
        publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/CICD_JOB/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                          }
            }
    stage('Create-Image') {
      steps {
        echo 'This stage will create a image of my application'
        sh 'docker build -t cbabu85/banking-apps:1.0 .'
                          }
            }
        }
}
