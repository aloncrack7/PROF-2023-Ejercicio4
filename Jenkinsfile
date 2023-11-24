pipeline {
    agent any

    stages {
        stage('Clone repo'){
            steps{
                checkout($class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    userRemoteConfigs: [[
                        url: 'https://github.com/aloncrack7/PROF-2023-Ejercicio4', 
                        credentialsId: 'token-for-jenkins']])
            }
        }

        stage('Backup Database') {
            steps {
                sh 'sqlite3 Employees.db ".backup tmp.db"'
            }
        }

        stage('Drop database') {
            steps {
                script {
                    def dropCommands = sh (
                        script: 'sqlite3 Employees.db "SELECT \'DROP TABLE IF EXISTS \' || name || \';\' AS sql_command FROM sqlite_master WHERE type = \'table\';"',
                        returnStdout: true
                    ).trim()

                    def filteredCommands = dropCommands.readLines().findAll { line ->
                        !line.contains('DROP TABLE IF EXISTS sqlite_sequence;')
                    }.join('\n')

                    sh (
                        script: "echo '${filteredCommands}' | sqlite3 Employees.db 2>/dev/null",
                    )
                }
            }
        }

        stage('Execute SQL Commands') {
            steps {
                sh 'sqlite3 Employees.db < sqlite.sql'
            }
        }

        stage('Restore Backup') {
            steps {
                sh 'sqlite3 Employees.db ".restore tmp.db"'
            }
        }

        stage('Cleanup') {
            steps {
                sh 'rm tmp.db'
            }
        }
    }
}
