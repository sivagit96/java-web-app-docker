node{
     
     def buildNumber=BUILD_NUMBER
     stage('SCM Checkout'){
        git url: 'https://github.com/sivagit96/java-web-app-docker.git',branch: 'master'
    }
    
    stage(" Maven Clean Package"){
      def mavenHome =  tool name: "Maven", type: "maven"
      def mavenCMD = "${mavenHome}/bin/mvn"
      sh "${mavenCMD} clean package"
      
    } 
    
    
    stage('Build Docker Image'){
         sh 'docker build -t 12docksiva/java-web-app .'
    }
    
    stage("Push Docker Image"){
        withCredentials([string(credentialsId: 'docksiva', variable: 'dockerhub')]) {
          sh "docker login -u 12docksiva -p ${dockerhub}"
        }
         sh "docker push 12docksiva/java-web-app"
     }
     
      stage('Deploy to docker container in docker deployer '){
          sshagent(['Docker_hub_pwd']) {
           sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.2.226 docker rm -f 12docksiva || true'
           sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.2.226 docker run -d -p 8080:8080 --name sivawebcontainer 12docksiva/java-web-app'           
       }
       
    }
     
     
}
