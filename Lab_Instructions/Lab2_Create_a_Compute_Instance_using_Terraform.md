# QATIP Azure Lab2

## Creating a virtual machine with Terraform

Last reviewed and tested - 18/11/26 20:26 - mcgreen@qa.com

PDF version deprecated and removed due to copy/paste issues.

## Contents

- [Lab Objectives](#lab-objectives)
- [Teaching Points](#teaching-points)
- [Before you begin](#before-you-begin)
- [Solution](#solution)
- [Task1 Review the Terraform Registry](#task1-review-the-terraform-registry)
- [Task2 Deploy the resources](#task2-deploy-the-resources)
- [Task3 Modify your deployment](#task3-modify-your-deployment)
- [Task4 Lab Clean-up](#task4-lab-clean-up)
- [Copyright](#copyright)

## Lab Objectives

In this lab you will:

- Review the Terraform registry documentation relating to Azure Windows Virtual Machines

- Deploy and then modify an Azure VM

- Destroy the deployment

## Teaching Points

This lab takes you through using Terraform to create a virtual machine in Azure. A virtual machine cannot exist in isolation however; it must have a virtual nic which must be on a subnet. The subnet must be part of a virtual network. All these resources must be part of a resource group.

## Before you begin

1. Ensure you have completed Lab0 before attempting this lab.

2. In the IDE terminal pane, enter the following command…

```powershell
cd c:\azurelabs\lab2
```

3. This shifts your current working directory to lab2. Ensure all commands are executed in this directory

4. Close any open files (except this one) and use the Explorer pane to navigate to and open the lab2 folder.

5. Open the provided empty `main.tf` file (Right click and choose `Open to the Side` so you can continue to see these instructions)

## Solution

The solution to this lab can be found in C:\azurelabs\solutions\lab2. Try to use this only as a last resort if you are struggling to complete the step-by-step processes.

## Task1 Review the Terraform Registry

1. Review Terraform documentation (Version 4.16.0 is used throughout this course)

- [Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs)

- [Azure Windows Virtual Machine](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/windows_virtual_machine.html)

- [Azure Network Interface](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/network_interface.html)

- [Azure Subnet](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/subnet)

## Task2 Deploy the resources

1. Navigate to [Azure Windows Virtual Machine](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/windows_virtual_machine.html)

2. Scroll down to the `Example Usage` section and copy the sample code into main.tf

3. Insert a new line in the provider block and add your subscription details which you noted down earlier;

```hcl
provider "azurerm" {
  features {}
  subscription_id = "your subscription id here"
}
```

4. Change the resource group name to “rg2-{suffix}” replacing {suffix} with the suffix you noted down earlier. Change the location from `West Europe` to `Denmark East`

```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg2-mf2fb5"
  location = "Denmark East"
}
```

5. Change the vm name to `vm1` and the vm size to `Standard_B2s_v2`;

```hcl
name                = "vm1"
resource_group_name = azurerm_resource_group.example.name
location            = azurerm_resource_group.example.location
size                = "Standard_B2s_v2"
```

6. Run `terraform init` ensuring you are in the correct working directory (C:\azurelabs\lab2)

7. Run `terraform plan` and review the proposed changes

8. Run `terraform apply` typing `yes` when prompted.

`NOTE` At time of last testing, a policy was preventing the creation of resources in Denmark East. If this problem is still present, then reset the location of the Resource group back to `West Europe` and retry `terraform apply` again.

9. Switch to the Azure Portal to confirm the creation of a resource group, vnet, sub-net, virtual nic and virtual machine

10. Return to the terminal and enter `terraform state list` to view the resources tracked in the state file..

11. Enter `terraform show`. Scroll up and note the last few digits of the `virtual_machine_id` of the newly created virtual machine. 

## Task3 Modify your deployment

1. Return to the IDE, edit `main.tf` by adding the following tags section to the end of the azurerm_windows_virtual_machine resource block, inserting it above the the final closing brace;

```hcl
tags = {
  Lab-Edit = "firstChange"
}
```

2. Run `terraform plan` and note the proposed changes ..

Plan: 0 to add, 1 to change, 0 to destroy.

This indicates that the existing VM will be updated in-situ.

3. Run `terraform apply`, review the proposed changes and type `yes` when prompted

4. Return to the Azure Portal and refresh the view

5. Review the virtual machine and verify that the tag has been added

6. Return to the terminal and enter `terraform show`. Scroll up and note the last few digits of the id of the virtual machine. This is the same value as in Task2, indicating that the change was applied to the existing virtual machine.

7. Edit the `main.tf` file to change the sku value, changing the vm operating system from 2016-Datacenter to 2022-Datacenter;

```hcl
source_image_reference {
  publisher = "MicrosoftWindowsServer"
  offer     = "WindowsServer"
  sku       = "2022-Datacenter"
  version   = "latest"
}
```

8. Run `terraform plan` and note the proposed changes ..

Plan: 1 to add, 0 to change, 1 to destroy.

This indicates that the existing VM will be replaced.

9. Run `terraform apply`, review the proposed changes and then type `yes` when prompted.

10. Return to the Azure Portal.

11. Refresh the Virtual Machine dashboard to confirm the updates.

12. Return to the terminal and enter `terraform show`. Scroll up and note the last few digits of the id of the virtual machine. This is a different value from Task2, indicating that the change of Operating system required the deletion of the original virtual machine and the creation of a replacement.

13. Takeaway: You need to be aware that some resource attributes are immutable, and some can be updated without the resource needing to be destroyed/replaced. In this case, modifying the machine tags can be done without recreating the virtual machine, whereas changing the Operating system would require destruction and recreation.

## Task4 Lab Clean-up

1. Run `terraform destroy` review the output and type `yes`

**Congratulations, you have completed this lab**

## Copyright

© 2026 QA Michael Coulling-Green. All rights reserved. These lab materials are provided as part of an authorised training course. Course attendees may reuse these materials for their own personal learning and reference outside of the training session. Unauthorised copying, redistribution, publication, or use of these materials to deliver training is prohibited without prior written permission from the author.
