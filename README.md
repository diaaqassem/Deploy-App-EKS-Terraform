
#  Containerize, Deploy, and Automate a Simple Node.js App on AWS EKS

##  Project Overview
This project demonstrates how to:
- Build and containerize a simple Node.js web application with an API returning **"Hello Eyego"**.
- Push the Docker image to **AWS Elastic Container Registry (ECR)**.
- Deploy the application to **AWS Elastic Kubernetes Service (EKS)** with high availability (2 replicas).
- Expose the application publicly via a **LoadBalancer**.
- Automate CI/CD using **Jenkins**.

---

##  **Project Structure**
<img width="242" height="267" alt="image" src="https://github.com/user-attachments/assets/736a6eae-8864-45a2-a70a-8353b2bd20b6" />



---

##  **Prerequisites**
- AWS CLI configured (`aws configure`)
- Terraform installed (`terraform -v`)
- Docker installed (`docker -v`)
- Kubectl installed (`kubectl version`)
- Jenkins server installed & integrated with GitHub webhook
- Slack (optional for notifications)

---

##  **Create AWS Infrastructure**
1. **Create S3 bucket** for Terraform backend:
```bash
   aws s3 mb s3://eyego-bucket
````

2. **Provision EKS cluster with Terraform:**

   ```bash
   cd EKS_terraform
   terraform init
   terraform apply
   ```
3. **Update kubeconfig to connect to EKS:**

   ```bash
   aws eks --region us-east-1 update-kubeconfig --name eyego-eks
   ```
4. **Verify cluster nodes:**

   ```bash
   kubectl get nodes
   ```

---

## 2 **Build & Push Docker Image to ECR**

1. **Get ECR URL** (from Terraform output or AWS console).
2. **Update `push-image.sh`** with the ECR repo URL.
3. **Run the script:**

   ```bash
   cd app
   sh push-image.sh
   ```

---

## 3 **Deploy to Kubernetes (EKS)**

1. **Update Deployment with ECR image URL**:

   ```yaml
   containers:
     - name: eyego-app
       image: 717*****8.dkr.ecr.us-east-1.amazonaws.com/eyego-repo:latest
   ```
2. **Apply Kubernetes resources:**

   ```bash
   kubectl apply -f k8s/deployment.yml
   kubectl apply -f k8s/service.yml
   ```
3. **Verify pods & service:**

   ```bash
   kubectl get pods
   kubectl get svc
   ```
4. **Access the app** via the LoadBalancer URL:

   ```bash
   curl http://<LOADBALANCER_URL>
   return: Hello Eyego

   ```

---

## 4 **CI/CD Automation with Jenkins**

The `Jenkinsfile` automates:

* Checkout from GitHub.
* Build and push Docker image to ECR.
* Update Kubernetes deployment.
* Notify Slack.

###  **Jenkinsfile Key Points**

* Webhook trigger from GitHub.
* Automatic tagging using Jenkins `BUILD_NUMBER`.
* `sed` command to replace the deployment image dynamically.

###  **Example Pipeline Flow**

1. Developer pushes code to `main`.
2. GitHub webhook triggers Jenkins.
3. Jenkins stages:

   * Build Docker image → Push to ECR.
   * Update Kubernetes deployment with new image tag.
   * Apply deployment to EKS.
4. Slack notification for success/failure.
---
<img width="1366" height="602" alt="image" src="https://github.com/user-attachments/assets/395deab5-f474-49b1-9944-2e6d84b9e993" />

<img width="1366" height="165" alt="image" src="https://github.com/user-attachments/assets/50ae7721-a41e-4544-a158-3082143dc1f7" />

