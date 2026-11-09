# QATIPv3 – Azure Lab5a

## Migrating a local Statefile to an Azure Storage Account

## Contents

- [Lab Objectives](#lab-objectives)
- [Teaching Points](#teaching-points)
- [Before you begin](#before-you-begin)
- [Solution](#solution)
- [Task1: Create a Storage Account for Remote State](#task1-create-a-storage-account-for-remote-state)
- [Task2: Review the Local Terraform State](#task2-review-the-local-terraform-state)
- [Task3: Update the Terraform Configuration](#task3-update-the-terraform-configuration)
- [Copyright](#copyright)

## Lab Objectives

In this lab you will:

1. Deploy resources using the provided code, creating a statefile on your local device.

2. Reconfigure the code to migrate the statefile to a central Azure storage account.

## Teaching Points

This lab will use terraform to deploy a network stack into Azure. This will create a local backend (Statefile) on the client device used for the deployment. This Statefile will then be migrated to a centrally controlled secure backend, an Azure storage account, as is more typical in a production environment.

## Before you begin

1. Ensure you have completed Lab0 before attempting this lab.

2. In the IDE terminal pane, enter the following command…

```powershell
cd c:\azurelabs\lab5
```

3. This shifts your current working directory to lab5. Ensure all commands are executed in this directory

4. Close any open files and use the Explorer pane to navigate to and open the lab5 folder.

5. Update main.tf with your lab subscription id and save the change.

6. Update network_module\main.tf with your resource group suffix.

7. Run terraform init and then terraform plan commands

8. Verify there are no errors and then run terraform apply followed by yes

9. Switch the console to review the deployment

You can carry on with the lab whilst the deployment progresses as this may take several minutes. You are deploying the following resources into the East US region; a resource group containing a VNet with 2 subnets, a Public IP address and 2 virtual machines. A total of 12 resources will be created. Note that a URL will be displayed as output. This is not functional at the moment and will be used in lab5b.

## Solution

The solution to this lab can be found in c:\azurelabs\solutions\lab5. Try to use this only as a last resort if you are struggling to complete the step-by-step processes.

## Task1: Create a Storage Account for Remote State

In this task you will create an Azure storage account and blob container for use as a terraform remote backend.

1. Navigate to the Azure Portal.

2. Search for and select Storage Accounts.

3. Click Create to create a new storage account….

| Setting | Value |
| --- | --- |
| Resource Group | create new rg-{suffix}-sa |
| Storage Account Name | remotestate{suffix} |
| Region | East US |
| Performance | Standard |
| Replication | Locally-redundant storage (LRS) |

4. Leaving other settings as defaults, click Review + Create and then Create.

5. Once the storage account is created, navigate to it and create a new Blob Container:

| Setting | Value |
| --- | --- |
| Name | terraform-state |
| Public access level | Private |

## Task2: Review the Local Terraform State

1. Wait until your deployment has completed..

2. Review the newly created terraform.tfstate file in the lab5 folder… Unless otherwise specified, the state file for your deployments will the in the local root directory. In all but trivial deployments the state file will be stored in a remote, shared location. You will move yours to the storage account you created in Task 1.

## Task3: Update the Terraform Configuration

1. Open main.tf in the root directory and add the following backend code to the end of the file, updating with your suffix

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-{suffix}-sa"
    storage_account_name = "remotestate{suffix}"
    container_name = "terraform-state"
    key = "terraform.tfstate"
  }
}
```

2. Run the following command to migrate the state: terraform init

3. During the initialization, Terraform will prompt to confirm the migration of the local state to Azure. Type yes when prompted.

4. Confirm that the state has been migrated by checking the blob container for the terraform.tfstate file. Make a note of its size. In Lab5b you will deploy additional resources, and this will be reflected by a growth in the state file size. Also notice that your local state file is now empty.

5. Do not delete any resources as they will be used in the next lab

**Congratulations, you have completed this lab**

## Copyright

© 2026 QA Michael Coulling-Green. All rights reserved. These lab materials are provided as part of an authorised training course. Course attendees may reuse these materials for their own personal learning and reference outside of the training session. Unauthorised copying, redistribution, publication, or use of these materials to deliver training is prohibited without prior written permission from the author.
