# QATIPv3 Azure Lab3

## VNet deployment using Terraform

## Contents

- [Lab Objectives](#lab-objectives)
- [Teaching Points](#teaching-points)
- [Before you begin](#before-you-begin)
- [Solution](#solution)
- [Task 1. Create the Resource group, VNet and Subnet](#task-1-create-the-resource-group-vnet-and-subnet)
- [Task 2. Create Routing Table and Routing Table Association](#task-2-create-routing-table-and-routing-table-association)
- [Task 3. Create Network Security Group](#task-3-create-network-security-group)
- [Task 4. Create Virtual Machine with Virtual Nic and Public IP](#task-4-create-virtual-machine-with-virtual-nic-and-public-ip)
- [Task 5. Testing](#task-5-testing)
- [Task 6. Lab Clean-up](#task-6-lab-clean-up)
- [Copyright](#copyright)

## Lab Objectives

1. In this lab, you will create the following resources...

| Setting | Value |
| --- | --- |
| Resource Group | “rg3-{suffix}” in West Europe |
| VNet | Using 10.0.0.0/16 |
| Subnet | Using 10.0.1.0/24 |
| Routing Table | Routing 0.0.0.0 traffic to the internet |
| Routing Table Association | between the subnet and the routing table |
| NSG | Allowing inbound RDP 3389 traffic |
| Security group association | between the subnet and the NSG |
| Virtual machine | “vm3” with a virtual nic and public IP |

This lab breaks a deployment into phases, each a separate task, to demonstrate component interdependencies:

- Task 1: Resource Group, VNet and subnet
- Task 2: Routing Table and Routing Table Association
- Task 3: Network Security Group and Network Security Group association
- Task 4: Virtual Machine with Virtual Nic and Public IP
- Task 5: Testing
- Task 6: Clean-up

## Teaching Points

This lab will take you through coding a multi-component cloud deployment into Azure using Terraform. You will deploy a virtual machine into a relatively simple network but even this has several components that need either to exist already or be created as part of the deployment. You have the option of attempting the tasks yourself with minimal guidance or following step-by-step instructions.

## Before you begin

1. Ensure you have completed Lab0 before attempting this lab

2. In the IDE terminal pane, enter the following command…

```powershell
cd c:\azurelabs\lab3
```

3. This shifts your current working directory to lab3. Ensure all commands are executed in this directory

4. Close any open files and use the Explorer pane to navigate to and open the lab3 folder

## Solution

The solution to this lab is in folder C:\azurelab\solutions\lab3. Try to use this only as a last resort if you are struggling to complete the step-by-step processes.

## Task 1. Create the Resource group, VNet and Subnet

### Try it yourself

Searching the Registry for guidance….

1. Add and configure an azurerm provider block into main.tf using version 4.16.0 and referencing your lab subscription.

2. Create an azurerm_resource_group resource group named rg3-{suffix}. Specify West Europe as the location.

3. Create an example azurerm_virtual_network resource within the resource group. Do not provision inline subnets or DNS Servers. Use a 10.0.0.0/16 address space and reference the name and location of the azurerm_resource_group you created in step 2.

4. Create a single example azurerm_subnet within the virtual network. Delegation is not required. Use a 10.0.1.0/24 address space and reference the azurerm_resource_group and azurerm_virtual_network resources created in steps 2 and 3.

5. Deploy these resources and validate their creation through the Azure Portal

### Step-by-Step

1. Open Terraform Registry Resources link [here](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs)

2. Scroll down to the ‘Example Usage’ section and copy the sample code into the Task1 section of main.tf

3. Change the version value to 4.16.0

4. Remove the resource_provider_registrations line

5. Add the following line under ‘features {}’, replacing ‘your subscription id here’ with your Azure lab subscription id..

```hcl
subscription_id = "your subscription id here"
```

6. Change the name of the resource group to rg3-{suffix}

7. Note how the azurerm_virtual_network resource block has implicit dependency on the azurerm_resource_group..

```hcl
resource_group_name = azurerm_resource_group.example.name
location = azurerm_resource_group.example.location
```

8. We will now add a subnet to the network. Open the Terraform Registry Resources link [here](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/subnet)

9. Scroll down to the ‘Example Usage’ section and copy just the ‘azurerm_subnet’ example block into main.tf, below your existing Task1 code.

10. Note how the new resource has implicit dependencies on both the azurerm_resource_group and azurerm_virtual_network...

```hcl
resource_group_name  = azurerm_resource_group.example.name
virtual_network_name = azurerm_virtual_network.example.name
```

11. Delete the entire delegation sub-block

12. Initialize terraform with terraform init

13. Deploy these resources using terraform plan followed by terraform apply. Enter yes when prompted.

14. Switch to the Azure Portal. Verify the creation of your resource group, the vnet with a single subnet.

## Task 2. Create Routing Table and Routing Table Association

### Try it yourself

1. Create an azurerm_route_table resource. Reference it to your azurerm_resource_group name and location. Configure local routing for all 10.0.1.0/16 destinations and the Internet for all others.

2. Create an azurerm_subnet_route_table_association resource. Associate it with the azurerm_subnet and azurerm_route_table resources you created in Task 1.

3. Deploy these resources and validate their creation through the Azure Portal

### Step-by-Step

1. Open Terraform Registry Resources link [here](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/route_table)

2. Familiarize yourself and then copy the azurerm_route_table example block into the Task2 section of main.tf excluding the resource group resource block.

3. Note how the new resource has implicit dependencies on azurerm_resource_group...

```hcl
location = azurerm_resource_group.example.location
resource_group_name  = azurerm_resource_group.example.name
```

4. Change the address_prefix to “10.0.0.0/16” so that is aligns to the vnet address space defines in Task 1.

5. Remove the tags sub-block

6. Add a second route block to add a default route to the internet…

```hcl
route {
  name = "Route-Internet"
  address_prefix = "0.0.0.0/0"
  next_hop_type = "Internet"
}
```

7. We now need to associate our subnet with the route table. Open Terraform Registry Resources link [here](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/subnet_route_table_association)

8. Copy the last resource block example, ‘azurerm_subnet_route_table_association’, into the bottom of the Task 2 block of main.tf

9. Note how the new resource has implicit dependencies on azurerm_subnet and azurerm_route_table...

```hcl
subnet_id = azurerm_subnet.example.id
route_table_id = azurerm_route_table.example.id
```

10. Deploy these resources using terraform plan followed by terraform apply

11. Switch to the Azure Portal. Verify the creation of 2 additional resources within your resource group.

## Task 3. Create Network Security Group

### Try it yourself

1. Create an azurerm_network_security_group resource.  Reference it to your resource group name and location. Configure the security rule to permit inbound traffic from the internet trying to reach any destination on TCP port

3389.

2. Associate this NSG with your Vnet subnet using an azurerm_subnet_network_security_group_association resource.

3. Deploy these resources and validate their creation through the Azure Portal.

### Step-by-Step

1. Open Terraform Registry Resources link [here](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/network_security_group)

2. Familiarize yourself and then copy the azurerm_network_security_group example block into Task3 section of main.tf

3. Note how the new resource has implicit dependencies on azurerm_resource_group...

```hcl
location = azurerm_resource_group.example.location
resource_group_name  = azurerm_resource_group.example.name
```

4. Change the destination_port_range to “3389”

5. Change the source_address_prefix to “Internet”

6. Remove the tags sub-block

7. We must now associate this security group with our subnet. Open Terraform Registry Resources link [here](https://registry.terraform.io/providers/hashicorp/azurerm/4.16.0/docs/resources/subnet_network_security_group_association)

8. Familiarize yourself and then copy the ‘azurerm_subnet_network_security_group_association’ sample block into the bottom of the Task 3 block in main.tf

9. Note how the new resource has implicit dependencies on azurerm_subnet and azurerm_network_security_group...

```hcl
subnet_id = azurerm_subnet.example.id
network_security_group_id = azurerm_network_security_group.example.id
```

10. Deploy these 2 new resources using terraform apply followed by yes

11. Switch to the Azure Portal. Click into your security group to verify the security rule and subnet association are created… The warning icon is highlighting the fact that a rule allows inbound traffic from any external IP. In production you would create more restrictive rules.

## Task 4. Create Virtual Machine with Virtual Nic and Public IP

1. The code to create a virtual machine, virtual nic and a static public ip has been pre-provisioned for lab brevity.

2. In main.tf, comment out or remove the lines `*/` and `\*` at the start and end of the Task 4 code block. This uncomments the entire block.

3. Note. Address any resource reference errors if your resource identifiers do not match those expected.

4. Deploy these 3 new resources using terraform apply

5. Note. If you receive errors regarding the machine size being used (“Standard_B2s”) then try "Standard_D2s_V3", "Standard_DS2_V2" or "Standard_DS3_v2".

## Task 5. Testing

1. Return to the Azure Portal

2. Review the list of resources in your resource group and then click on virtual machine vm3

3. From the top menu click Connect > Connect > Download RDP

4. Download the RDP file, as prompted, and open

5. Connect, Accept the certificate validation and, when prompted, login with your credentials from the terraform file (VM configuration) Note: the virtual machine may take a little while to become ready to accept an RDP connection

6. Log in using `TFadminuser/TFP@$$w0rd1234!`

7. Having verified connectivity, you can disconnect for the virtual machine without waiting for it to fully initialize…

## Task 6. Lab Clean-up

1. Run terraform destroy and confirm with yes when prompted.

**Congratulations, you have completed this lab**

## Copyright

© 2026 QA Michael Coulling-Green. All rights reserved. These lab materials are provided as part of an authorised training course. Course attendees may reuse these materials for their own personal learning and reference outside of the training session. Unauthorised copying, redistribution, publication, or use of these materials to deliver training is prohibited without prior written permission from the author.
