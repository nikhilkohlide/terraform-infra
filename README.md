# Terraform Infra Project

## Project Overview
This project provisions a complete AWS infrastructure using Terraform.  
It includes VPC, subnets, Internet Gateway, NAT Gateway, Security Groups, Auto Scaling Group (ASG), Application Load Balancer (ALB), Launch Templates, IAM roles, and environment separation.  

---

## Architecture Overview

              ┌────────────────────────┐
              │        Internet        │
              └────────────┬──────────┘
                           │
                      ┌────▼────┐
                      │  ALB    │
                      └────┬────┘
                           │
                ┌──────────┴──────────┐
                │                     │
       ┌────────▼────────┐   ┌────────▼────────┐
       │   EC2 ASG 1     │   │   EC2 ASG 2     │
       │ (Private Subnet)│   │ (Private Subnet)│
       └────────┬────────┘   └────────┬────────┘
                │                     │
           ┌────▼─────┐         ┌─────▼────┐
           │  IAM Role│         │  IAM Role│
           └──────────┘         └─────────┘

- Public Subnets host ALB and NAT Gateway.
- Private Subnets host EC2 instances behind ASG.
- IAM roles attached to EC2 instances for secure AWS access.
- Environment-specific values are parameterized using `terraform.tfvars`.
- Lifecycle rules safeguard critical resources (`prevent_destroy = true`).

---

## How to Run the Project

1. **Clone the repository**
```bash
git clone https://github.com/nikhilkohlide/terraform-infra.git
cd terraform-infra


```
2. **Initialize Terraform**

```
terraform init

```
3. Select Workspace for Environment

```
terraform workspace new dev     # for development environment
terraform workspace new prod    # for production environment
terraform workspace select dev  # switch to dev

```
4.Plan the Infrastructure
```
terraform plan -var-file="terraform.tfvars"

```
5.Apply the Infrastructure
```
terraform apply -var-file="terraform.tfvars"
```

6.Destroy the Infrastructure (if needed)
```
terraform destroy -var-file="terraform.tfvars"
```

## Assumptions and Trade-offs

AWS credentials are managed externally (no hard-coded credentials in Terraform code).

Using Terraform workspaces to separate dev and prod environments.

Provisioners are used sparingly (only for bootstrapping Nginx).

Critical resources are protected using lifecycle rules (prevent_destroy = true).

Simplified networking with one ALB, 2 private subnets for EC2 instances.

Expected Outcomes

Successful creation of VPC, subnets, IGW, NAT, Security Groups, ALB, Launch Template, Auto Scaling Group, and IAM roles.

Environment separation with workspaces and parameterized configuration.

All sensitive credentials and secrets are not stored in code.

Repeatable deployment across environments using the same codebase.




---


