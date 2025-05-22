# .modules Directory

This folder contains reusable Bicep modules for Azure deployments. Each `.bicep` file defines a specific resource or set of resources, such as storage accounts, web apps, Application Insights, and Log Analytics workspaces. These modules are intended to be referenced from other Bicep files in the project to promote modularity and reusability.

## Modules Included

- `applicationinsights.bicep`: Deploys an Application Insights instance.
- `loganalytics.bicep`: Deploys a Log Analytics workspace.
- `storageaccount.bicep`: Deploys a Storage Account.
- `webapp.bicep`: Deploys an Azure Web App.

Refer to each module's comments and parameters for usage