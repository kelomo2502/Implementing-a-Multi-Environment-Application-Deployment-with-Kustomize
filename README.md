# Kustomize Capstone: Multi-Environment Kubernetes Deployment

This project demonstrates how to deploy a web application to a Kubernetes cluster using [Kustomize](https://kustomize.io/) with separate configurations for **development**, **staging**, and **production** environments. It also includes a CI/CD pipeline (GitHub Actions) to automate deployments based on environment-specific changes.

---

## 🗂️ Project Structure

```plaintext
kustomize-capstone/
│
├── base/                       # Base Kubernetes resources (common across all environments)
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
│
├── overlays/                  # Environment-specific customizations
│   ├── dev/
│   │   └── kustomization.yaml
│   ├── staging/
│   │   └── kustomization.yaml
│   └── prod/
│       └── kustomization.yaml
│
├── .github/workflows/         # GitHub Actions CI/CD pipelines
│   └── deploy.yaml
│
├── .gitignore
└── README.md
📌 Use Case
You are deploying a web application to Kubernetes clusters for development, staging, and production, using Kustomize to manage configuration differences and GitHub Actions for continuous delivery.

✅ Tasks Completed
1. Set Up Project
Created kustomize-capstone project directory.

Structured project using Kustomize conventions: base/, overlays/dev, overlays/staging, overlays/prod.

2. Git Initialization
Initialized a Git repository.

Created a .gitignore to exclude generated and sensitive files.

3. Base Configuration
Defined common Kubernetes manifests in the base/ folder.

Created a kustomization.yaml to reference base manifests.

4. Environment-Specific Overlays
Added overlays for dev, staging, and prod.

Customized each environment with:

Varying replica counts

Specific environment variables

Different resource requests/limits

5. CI/CD Integration
Set up GitHub Actions to automate deployment.

Configured the workflow to:

Detect changes in the respective overlay

Deploy to the targeted Kubernetes namespace or cluster using kubectl apply -k overlays/<env>

6. Pipeline Testing
Successfully tested updates to Kustomize overlays.

Verified deployments are automatically applied to the correct Kubernetes environment.

7. Secrets and ConfigMaps
Used Kustomize generators to create:

ConfigMaps (from literal or file)

Secrets (from literals or external sources)

Environment-specific secrets and configs are scoped to overlays.

🚀 Deployment Instructions
Prerequisites
Kubernetes cluster (e.g., Minikube, EKS, GKE)

kubectl configured and authenticated

Kustomize CLI (or kubectl kustomize plugin)

GitHub repository with Actions enabled

Deploy Manually
To deploy an environment manually:

bash
Copy
Edit
# Clone the repo
git clone https://github.com/kelomo2502/kustomize-capstone.git
cd kustomize-capstone

# Deploy to dev
kubectl apply -k overlays/dev

# Or deploy to staging
kubectl apply -k overlays/staging

# Or deploy to production
kubectl apply -k overlays/prod
🔁 CI/CD Pipeline with GitHub Actions
Triggering Deployment
The pipeline is triggered automatically when changes are pushed to the overlays:

yaml
Copy
Edit
on:
  push:
    paths:
      - 'overlays/dev/**'
      - 'overlays/staging/**'
      - 'overlays/prod/**'
Sample Workflow (.github/workflows/deploy.yaml)
yaml
Copy
Edit
name: Deploy with Kustomize

on:
  push:
    paths:
      - 'overlays/**'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repo
      uses: actions/checkout@v3

    - name: Set up kubectl
      uses: azure/setup-kubectl@v3

    - name: Deploy Kustomize Overlay
      run: |
        if [[ "${{ github.event.head_commit.message }}" == *"[dev]"* ]]; then
          kubectl apply -k overlays/dev
        elif [[ "${{ github.event.head_commit.message }}" == *"[staging]"* ]]; then
          kubectl apply -k overlays/staging
        elif [[ "${{ github.event.head_commit.message }}" == *"[prod]"* ]]; then
          kubectl apply -k overlays/prod
        fi
Note: Add cluster authentication using a service account, GitHub secret, or external action for real deployments.

🔐 Secrets & ConfigMaps
Manage secrets and configs as follows:

In kustomization.yaml:

yaml
Copy
Edit
configMapGenerator:
  - name: app-config
    literals:
      - ENV=development
      - DEBUG=true

secretGenerator:
  - name: db-secret
    literals:
      - DB_USER=admin
      - DB_PASS=securepassword
Avoid committing sensitive secrets. Use .gitignore and secret management tools like Sealed Secrets or External Secrets.

🧪 Testing
Verify deployments by checking Kubernetes resources:

bash
Copy
Edit
kubectl get all -n <namespace>
kubectl logs <pod-name>
Make changes to an overlay and push to the repo to observe automated updates via the CI/CD pipeline.

📚 Resources
Kustomize Documentation

GitHub Actions Docs

Secure Secret Management

📦 Future Enhancements
Integrate Sealed Secrets or External Secrets

Add Helm comparison and migration option

Monitor deployments using Prometheus + Grafana

🧑‍💻 Author
oyewunmi Gbenga Kelvin
DevOps Engineer | Kubernetes Enthusiast
LinkedIn • GitHub