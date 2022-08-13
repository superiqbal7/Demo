pipeline {

    agent {
        label "any"
    }
    //not needed

    //     environment {
    //             EXAMPLE_CREDS = credentials('example-credentials-id')
    //     }

 	stages {
        stage('build'){
          steps{
              catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {

                     sh " rm -r /var/jenkins_home/workspace/devopsmakeeasy/artifact"
                   //sh " rm -r /var/jenkins_home/workspace/artifact"
              }
              sh "ls -ll"
              sh "pwd"
              sh "ls -ll /var/jenkins_home/workspace"
              sh "pwd"
              sh "ls"
              sh "mkdir /var/jenkins_home/workspace/artifact"
              sh "ls -ll /var/jenkins_home/workspace"
              sh "cp -r /var/jenkins_home/workspace/devopsmakeeasy/. /var/jenkins_home/workspace/artifact/  "
              sh "ls -la /var/jenkins_home/workspace/artifact"
              sh "mv /var/jenkins_home/workspace/artifact/ /var/jenkins_home/workspace/devopsmakeeasy/ "
              sh "ls -la /var/jenkins_home/workspace/devopsmakeeasy"
              sh "ls -ll /var/jenkins_home/workspace/devopsmakeeasy/artifact"
              sh "tar -zcvf artifact.tar.gz /var/jenkins_home/workspace/devopsmakeeasy/artifact "
              sh "ls -la /var/jenkins_home/workspace/devopsmakeeasy/"
              
              sh('curl -v -u ${nexus_admin}:${nexus_pass} --upload-file artifact.tar.gz http://147.182.235.195:8081/repository/maven-nexus-repo/var/jenkins_home/workspace/devopsmakeeasy/artifact/artifact.tar.gz')
              //sh "chmod +x /var/jenkins_home/workspace/devopsmakeeasy/artifact/artifact.tar.gz"
        
      script{
                    def remote = [:]

                remote.name = "${remote_name}"
                remote.host = "${remote_host}"
                remote.user = "${remote_user}"
                remote.password = "${remote_pass}"
                remote.allowAnyHosts = true
                //i want to run the script from server to node end

                    //writeFile file: 'srcipt_devops.sh', text: 'ls -lrt'
                   sshPut remote: remote, from: '/var/jenkins_home/workspace/devopsmakeeasy/srcipt_devops.sh', into: '/var/www/'
                    sshCommand remote: remote, command: "cd .. && cd var/www/ && chmod +x srcipt_devops.sh && ./srcipt_devops.sh"
                    sshCommand remote: remote, command: "cd .. && cd var/www/devopsmakeeasy.com/ && chmod +x srcipt_larabuild.sh && ./srcipt_larabuild.sh"
}
}
}
stage("unit") {
            steps {
                
                sh 'php --version'
                sh 'composer update --ignore-platform-req=ext-gd'
                sh 'composer --version'
                sh 'cp .env.example .env'
                sh 'php artisan key:generate'
            }
        }
        stage("Unit test") {
            steps {
                //sshCommand remote: remote, command: "cd .. && cd var/www/devopsmakeeasy.com/ && php artisan test"
                sh 'php artisan test'
            }
        }
                     stage('Unit Testing') {
                         steps{
                           sshCommand remote: remote, command: "cd .. && cd var/www/devopsmakeeasy.com/ && php artisan test"
                        }
}
                  //sshCommand remote: remote, command: "cd .. && cd var/www/ && curl --create-dirs -O --output ../var/www/ http://157.245.255.2:8081/repository/maven-nexus-repo/var/jenkins_home/workspace/devopsmakeeasy/artifact/artifact.tar.gz && pwd && ls -la && tar -xvzf artifact.tar.gz && cd /var/www/var/jenkins_home/workspace/devopsmakeeasy/artifact && mv * /var/www/ "
             stage('Code Coverage') {
                         steps{
                             sh "vendor/bin/phpunit --coverage-html 'reports/coverage'"
              }
             }
  stage('Static code analysis larastan') {
                         steps{
                             echo 'code analysis..'
              }
             }
 	 stage('Static code analysis phpcs') {
                         steps{
                             echo 'Testing..'
              }
     }
 	     stage('docker build') {
                         steps{
                               echo 'docker..'
              }
             }
 	 stage('docker push') {
                         steps{ 
                             echo 'docker push..'
              }
             }
             stage('deploy to staging') {
                         steps{ 
                             echo 'docker push..'
              }
             }
             stage('Acceptance test curl') {
                         steps{ 
                             echo 'docker push..'
              }
             }
             stage('Acceptance test codeception') {
                         steps{ 
                             echo 'docker push..'
              }
             }
 	}  
        }