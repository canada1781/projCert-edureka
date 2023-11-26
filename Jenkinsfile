pipeline {
    agent { label 'slave' }
    stages {
        stage('php-docker-build') {
            steps {
                script {
                    sh '''
                        docker build -t my-php-website-image .
                    '''
                }
            }
        }
        stage('php-docker-deploy') {
            steps {
                script {
                    sh '''
                        docker run -p 8081:80 my-php-website-image -d
                    '''
                }
            }
        }
    }
}
