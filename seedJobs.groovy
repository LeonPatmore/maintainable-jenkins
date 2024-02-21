pipelineJob("Seed") {
    definition {
        cps {
            sandbox(true)
            script("""
pipeline {
    agent any
    stages {
        stage("Hello") {
            steps {
                script {
                    def response = httpRequest 'https://api.github.com/repos/LeonPatmore/maintainable-jenkins/contents/remoteJobs.groovy'
                    def json = readJSON text: response.content
                    def contentEncoded = json["content"]
                    def content = new String(contentEncoded.decodeBase64())
                    echo "\${content}"
                    writeFile file: "jobs.groovy", text: content
                    jobDsl targets: "jobs.groovy"
                }
            }
        }
    }
}

""")
        }
    }
}
