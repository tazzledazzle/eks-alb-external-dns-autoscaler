# ✨ Terraform‑EKS‑ALB‑external‑dns‑autoscaler mini‑module

Spin up an opinionated EKS cluster—ready for production traffic—in **~15 minutes**.

### Small but polished

* **Single `terraform apply`** → production‑grade cluster with ingress, DNS, elasticity.  
* **IRSA everywhere** → no node IAM *god‑mode* policies.  
* **Mermaid diagram + sample output** in README for portfolio‑friendly docs.  
* **Module versions pinned** so reviewers can reproduce the exact stack.  

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


---

## Sample Terraform apply Output (truncated)

 ```bash
 Apply complete! Resources: 61 added, 0 changed, 0 destroyed.

Outputs:

cluster_endpoint = "https://DEE5CE87E78A1234567890.yl4.us-west-2.eks.amazonaws.com"
cluster_name     = "demo-eks"
region           = "us-west-2"

 ```

 Cluster is live! Create an `Ingress` manifest with annotation `alb.ingress.kubernetes.io/load-balancer-type: external` and watch the ALB spin up 🪄

 ---

 ## Cleaning up

 ```bash
 terraform destroy
 ```

 Destroys all AWS resources (VPC, EKS, ALB, IAM roles, etc.).

 ---

 ## License

 MIT

