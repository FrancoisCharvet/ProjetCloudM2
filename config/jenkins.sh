pipeline {
  agent {
    label 'vote-cloud-slave'
  }
  stages {
    stage('Cloning Github Repository') {
      steps {
        git branch: 'main', credentialsId: 'GitHubFchar', url: 'https://github.com/FrancoisCharvet/ProjetDevopsM2.git'
      }
    }
    stage('Building Project Image') {
      steps {
        script {
          dir('webapi') {
            bat 'docker build -t francoischarvet/projet-devops-m2:1.0 .'
          }
        }
      }
    }
	stage('Publish Project Image') {
      steps {
        bat 'docker push francoischarvet/projet-devops-m2:1.0'
      }
    }
	stage('Starting Minikube') {
	  steps {
	    script {
		  bat 'minikube start'
		}
	  }
	}
    stage('Enable Ingress') {
	  steps {
	    script {
		  bat 'minikube addons enable ingress'
		  bat 'minikube addons enable ingress-dns'
		}
	  }
	}
    stage('Apply Backend Deployment') {
      steps {
	    script {
		  dir('config') {
            bat 'kubectl apply -f devops-deployment.yml'
		  }
	    }
      }
    }
	stage('Apply Backend Service') {
      steps {
	    script {
		  dir('config') {
            bat 'kubectl apply -f devops-service.yml'
		  }
		}
      }
    }
	stage('Apply Ingress') {
      steps {
	    script {
		  dir('config') {
            bat 'kubectl apply -f devops-ingress.yml'
	      }
	    }
      }
    }
    stage('Display Pods, Services and Deployments Information') {
      steps {
	    script {
          bat 'kubectl get pods,services,deployments'
		}
      }
    }
  }
}
