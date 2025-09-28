pipeline{
    agent {label "dev-node1"}
    stages{
        stage("clone"){
            steps{
                git url: "https://github.com/Gagandeepsingh9/ChatApp.git", branch: "week6-CICD"
            }
        }
        stage("build"){
            steps{
                sh "docker build -t mrsinghdocker/chatapp:jenkins ."
            }
        }
        stage("test"){
            steps{
                sh "trivy image mrsinghdocker/chatapp:jenkins -o image_scan.json"
            }
        }
        stage("push"){
            steps{
                withCredentials([usernamePassword(
                    credentialsId: "MY_DOCKER_CREDS",
                    usernameVariable: "DOCKER_USER",
                    passwordVariable: "DOCKER_PASS"
                    )]){
                sh "echo ${env.DOCKER_PASS} | docker login -u ${env.DOCKER_USER} --password-stdin"
                sh "docker push ${env.DOCKER_USER}/chatapp:jenkins"
                }
            }
        }
        stage("deploy"){
            steps{
                sh "docker compose up -d"
            }
        }
    }
    post{
    success{
        emailext(
            to: "gagan13.ca@gmail.com",
            subject: "CONGRATULATIONS",
            body: "YOUR BUILD IS SUCCESSFULLY DEPLOYED"
        )
    }
    failure{
        emailext(
            to: "gagan13.ca@gmail.com",
            subject: "BAD NEWS",
            body: "YOUR BUILD FAILED."
        )
    }
}
}
