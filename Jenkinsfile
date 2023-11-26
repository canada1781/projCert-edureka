// pipeline {
//     agent { label 'slave' }
//     stages {
//         stage('php-docker-build') {
//             steps {
//                 script {
//                     sh '''
//                         docker build -t my-php-website-image .
//                     '''
//                 }
//             }
//         }
//         stage('php-docker-deploy') {
//             steps {
//                 script {
//                     sh '''
//                         docker run -p 8081:80 -d my-php-website-image
//                     '''
//                 }
//             }
//         }
//     }
// }


pipeline {
    agent { label 'slave' }
    stages {
        stage('Install and configure Puppet agent - job 1') {
            steps {
                script {
                    sh '''
                        wget https://apt.puppetlabs.com/puppet7-release-bionic.deb
                        sudo dpkg -i puppet7-release-bionic.deb
                        sudo apt-get update
                        sudo apt-get install -y puppet-agent
                        sudo /opt/puppetlabs/bin/puppet config set server puppet.example.com --section main
                        sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true
                    '''
                }
            }
        }

        stage('Install Docker using ansible playbook - job 2') {
            steps {
                script {
                    sh '''
                        ansible-playbook docker_install.yml
                    '''
                }
            }
        }

        stage('php-docker-build - job 3.1') {
            steps {
                script {
                    sh '''
                        docker build -t my-php-website-image .
                    '''
                }
            }
        }
        stage('php-docker-deploy - job 3.2') {
            steps {
                script {
                    def containerId

                    try {
                        containerId = sh(script: "docker run -d -p 8081:80 my-php-website-image:latest", returnStdout: true).trim()
                        sh "echo 'Container is running with ID: ${containerId}'"
                    } catch (Exception e) {
                        echo "Deployment failed. Deleting the container..."
                        if (containerId != null) {
                            sh "docker stop ${containerId} && docker rm ${containerId}"
                        }
                    }
                }
            }
        }
    }
}
