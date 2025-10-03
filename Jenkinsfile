@Library("cicd_shared_library") _
pipeline{
    agent {label "dev-node1"}
    stages{
        stage("clone"){
            steps{
                script{
                cloning("https://github.com/Gagandeepsingh9/ChatApp.git","week6-CICD")
                }
            }
        }
        stage("build"){
            steps{
                script{
                building("mrsinghdocker","chatapp:jenkins")
                }
            }
        }
        stage("test"){
            steps{
                script{
                testing("mrsinghdocker","chatapp:jenkins")
                }
            }
        }
        stage("push"){
            steps{
                script{
                    docker_push("MY_DOCKER_CREDS","chatapp:jenkins")
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
