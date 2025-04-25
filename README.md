# Azure Enterprise Setup (Level 3 - Bicep)

This project simulates a real-world enterprise Azure environment using **Bicep** for infrastructure as code. It includes governance, tagging, and automation-ready structure for showcasing professional cloud engineering skills.

## 📦 What This Bicep Template Does

- Deploys a **resource group** (`rg-dummy-test`) in `australiaeast`
- Deploys a **storage account** with `Standard_LRS` SKU
- Applies a **Department tag** (default: `Development`) to all resources

## 🧱 Technologies Used

- [Azure Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview)
- Azure CLI
- GitHub Actions (CI/CD coming soon)

## 🚀 How to Deploy (Manual CLI)

```bash
az deployment sub create \
  --location australiaeast \
  --template-file ./azure_enterprise_setup.bicep \
  --parameters departmentTag="Development"
```

## 💼 Use Cases
- Practice enterprise-level Azure governance
- Demonstrate tagging enforcement and repeatable deployments
- Build portfolio projects to stand out in cloud and DevOps job applications

## 🔜 Coming Soon
- Azure Policy Definitions via Bicep
- RBAC Role Assignments
- Full GitHub Actions automation pipeline

---

> ✍️ Created by Rhys as part of a multi-level mock Azure enterprise environment. Built to simulate real-world cloud infrastructure for learning and job readiness.
