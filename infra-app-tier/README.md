## Overview

This module provisions a fully functional application tier in Azure, built using modular Bicep templates and deployed through GitHub Actions.

It includes networking, security, and compute infrastructure designed to reflect real-world enterprise standards — all governed by policy-compliant metadata tagging.

## What This Deploys

- **Virtual Network (VNet)**  
  - Custom IP space (`10.0.0.0/16`) with a dedicated subnet for VMs  
  - NSG enforcing HTTP (port 80) inbound access only

- **Network Security Group (NSG)**  
  - Scoped to the VM subnet  
  - Includes rules for basic web access

- **Azure Load Balancer**  
  - Public IP frontend  
  - Backend pool distributes traffic across two VMs  
  - TCP health probe on port 80

- **Virtual Machines**  
  - Two Windows Server VMs (`Standard_B1s`)  
  - Boot diagnostics enabled (linked to a storage account)  
  - NICs assigned and load-balanced  
  - Credentials securely managed via GitHub Secrets  
  - **Tag: `Department=Development`** (required by enterprise policy)

## Deployment Method

This tier is automatically deployed using **GitHub Actions** when changes are pushed to this folder.

The CI/CD pipeline uses:
- `azure/arm-deploy@v1` for Bicep template deployment
- `@secure()` Bicep parameters for password security
- GitHub Secrets for credential injection

📁 **Deployment template:** [`main.bicep`](./main.bicep)  
📄 **Workflow:** [`.github/workflows/deploy-app-tier.yml`](../.github/workflows/deploy-app-tier.yml)

## Skills Demonstrated

- Infrastructure as Code with Bicep  
- CI/CD automation using GitHub Actions  
- Azure networking and load balancing  
- Virtual machine provisioning with diagnostics  
- Azure Policy compliance (tag enforcement)  
- Secure DevOps practices using secrets management

## Notes

- All resources are deployed to the `rg-dev-site` resource group in **Australia East**
- VM passwords must meet Azure complexity requirements
- The subnet, NSG, and Load Balancer are designed to be reusable for future application tiers
