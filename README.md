# ✨ Terraform‑EKS‑ALB‑external‑dns‑autoscaler mini‑module

Spin up an opinionated EKS cluster—ready for production traffic—in **~15 minutes**.

---

## Architecture

```mermaid
flowchart TD
  
  A(Route 53) --> C(ALB Ingress Controller)
  C --> D[EKS Control Plane]
  
%%   D -->|Helm Charts| E[worker nodes (ASG)]
D -->|helmCharts| E
  D --> F[external‑dns]
  D --> G[cluster‑autoscaler]
  G -->|scale| E[worker nodes ASG]
  C -->|creates| ALB{{AWS ALB}}
  ```

* AWS Load Balancer Controller provisions ALBs/NLBs for Kubernetes Ingress resources.
* external‑dns watches Ingress + Service objects and updates Route 53 records.
* cluster‑autoscaler watches pending pods & scales the managed node group.

---

## Prerequisites


| Tool | Tested Version |
| ----- | ------- |
| Terraform    | 1.6+    |
| AWS CLI   | 2.15+    |
| kubectl   | 1.30+   |


Ensure you have an AWS account with AdministratorAccess or equivalent IAM permissions.

## Quickstart

```bash
# 1. Clone and enter directory
git clone https://github.com/tazzledazzle/eks‑alb‑external‑dns‑autoscaler.git
cd eks‑alb‑external‑dns‑autoscaler

# 2. Configure backend / state (optional)
# terraform init -backend-config="bucket=my-tf-state"

# 3. Deploy
terraform init
terraform apply -auto-approve \
  -var="domain_filter=example.com" \
  -var="cluster_name=demo-eks"

# 4. Validate
aws eks update-kubeconfig --region us-west-2 --name demo-eks
kubectl get nodes
kubectl get pods -n kube-system

```