node{
     
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
    
    stage('Push Docker Image'){
        withCredentials([string(credentialsId: 'docksiva', variable: 'dockerhub')]) {
          sh "docker login -u 12docksiva -p ${dockerhub} 172.31.14.127:8083"
        }
        sh 'docker push 172.31.14.127:8083/12docksiva/java-web-app'
     }
     
      stage('Run Docker Image In Dev Server'){
        
        def dockerRun = ' docker run  -d -p 8080:8083 --name java-web-app 12docksiva/java-web-app'
         
         sshagent(['12docksiva']) {
          sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.14.127 docker stop java-web-app || true'
          sh 'ssh  ubuntu@172.31.14.127 docker rm java-web-app || true'
          sh 'ssh  ubuntu@172.31.14.127 docker rmi -f  $(docker images -q) || true'
          sh "ssh  ubuntu@172.31.14.127 ${dockerRun}"
       }
       
    }
     
     
}
