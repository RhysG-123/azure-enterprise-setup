# Azure Enterprise Mock Environment

## Overview
This project simulates a real-world enterprise Azure environment, including Management Groups, Subscriptions, Resource Groups, Policies, RBAC access control, and Cost Management.

It is built using infrastructure as code (Bicep) and automated deployment through GitHub Actions (CI/CD pipeline).

## Technologies Used
- Microsoft Azure
- Azure Bicep
- Azure Management Groups
- Azure Policies
- Azure Role-Based Access Control (RBAC)
- Azure Cost Management
- GitHub Actions (CI/CD Automation)

## What This Project Deploys
- Top-level management groups and department sub-groups
- Role-based access control (RBAC) assignments for users
- Subscription-wide policies enforcing:
  - Resource location restrictions (Australia East only)
  - Mandatory Department tagging
- A storage account (free-tier) for testing
- Budget alert for subscription cost control

## How It Works
- Infrastructure is defined using Bicep templates (`main.bicep` and `modules/storage.bicep`).
- A GitHub Actions workflow automatically deploys the environment to Azure whenever changes are pushed to the repository.
- Unique deployment names are used to prevent deployment conflicts.
- Idempotent deployments ensure that no duplicate resources are created.

## Skills Demonstrated
- Azure Governance and Policy Management
- Infrastructure as Code (IaC) with Bicep
- GitHub Actions CI/CD Automation
- Cloud Cost Management
- Enterprise Cloud Architecture

## License
This project is licensed under the [MIT License](LICENSE).
