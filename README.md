## ST2DCE-PRJ-2324S9-SE1

# Web API Application

This application is a simple Go web service that provides information about the author and exposes a few endpoints. It's designed to be run in a Docker container. The provided Jenkins pipeline automates the process of building, publishing, and deploying the application using Minikube and Kubernetes.
Usage


## Building the Docker Image:
To build the Docker image, use the provided Dockerfile. Ensure you have Docker installed and run the following command in the project root directory:

docker build -t francoischarvet/projet-devops-m2:1.0 .


## Publishing the Docker Image:
After building the image, use the Jenkins pipeline to publish it to the specified Docker registry (replace 'francoischarvet' with your DockerHub username if needed):

docker push francoischarvet/projet-devops-m2:1.0


## Deploying to Kubernetes with Minikube:
The Jenkins pipeline automates the deployment to a local Minikube Kubernetes cluster. Ensure you have Minikube installed and running. The pipeline applies the necessary Kubernetes YAML files for deployment, service, and ingress:

minikube start  # if not already started
minikube addons enable ingress
minikube addons enable ingress-dns
kubectl apply -f config/devops-deployment.yml
kubectl apply -f config/devops-service.yml
kubectl apply -f config/devops-ingress.yml


## Monitoring with Prometheus Alert Rules:

The prometheus-alert-rules.yml file contains alerting rules for Prometheus. These rules define alerts based on the status of instances. To use these rules, configure your Prometheus server to include this file.
Endpoints

    /: Home page with a welcome message.
    /aboutme: Information about the author (EfreiParis in this case).
    /whoami: JSON response with author details.


## Jenkins Pipeline:

The Jenkins pipeline (jenkins.sh) automates the entire process, including cloning the repository, building the Docker image, pushing it to the registry, starting Minikube, enabling Ingress, and deploying the application to Kubernetes. The pipeline also displays information about pods, services, and deployments.

### Note: Make sure to customize the Jenkins pipeline according to your environment, credentials, and project structure.