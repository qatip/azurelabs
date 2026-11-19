# QATIP Azure Lab1

## A sample Terraform deployment

Last reviewed and tested - 18/11/26 18:17 - mcgreen@qa.com

PDF version deprecated and removed due to copy/paste issues.

## Contents

- [Lab Objectives](#lab-objectives)
- [Teaching Points](#teaching-points)
- [Before you begin](#before-you-begin)
- [Task1 Review the sample terraform configuration file](#task1-review-the-sample-terraform-configuration-file)
- [Task2 Run Terraform & Test](#task2-run-terraform--test)
- [Task3 Examine the state file](#task3-examine-the-state-file)
- [Task4 Destroy the deployment](#task4-destroy-the-deployment)

## Lab Objectives

In this lab, you will:

- Review a simple sample terraform deployment configuration file

- Deploy a local Docker image and container

- Test the container

- Modify the deployment

- Test the modified deployment

- Destroy the deployment

## Teaching Points

This lab introduces you to Terraform and guides you through using it to interact with locally installed Docker. It introduces providers, used to indicate the infrastructure that will be managed, and also the structure and composition of terraform files. You will review an example terraform file before initializing the client, planning, and then applying the deployment. You will then modify the deployment before eventually destroying it.

## Before you begin

1. Before you begin this lab ensure you have completed Lab0.

2. On your remote virtual machine; start `Docker Desktop` using the desktop shortcut provided and then use settings to ensure the docker service is listening on TCP port 2375 without TLS: **Settings > General > Expose daemon on tcp://localhost:2375 without TLS**.

3. Select `Close` or `Apply & Restart` and then exit settings using the lower `X` at top-right

4. Verify no containers or images exist.

5. Minimize Docker but keep it running in the background.

## Task1 Review the sample terraform configuration file

1. In VSC, open and review C:\azurelabs\lab1\main.tf

```hcl
1   terraform {
2     required_providers {
3       docker = {
4         source  = "kreuzwerker/docker"
5         version = "4.2.0"
6       }
7     }
8   }
9
10  provider "docker" {
11    host = "tcp://localhost:2375"
12  }
13
14  # Pull the image
15  resource "docker_image" "httpd" {
16    name = "httpd:latest"
17  }
18
19  # Create a container
20  resource "docker_container" "webserver" {
21    image = docker_image.httpd.image_id
22    name  = "webserver"
23    ports {
24      internal = 80
25      external = 88
26    }
27  }
```

### Breaking It Down

### Defining the Terraform Block

```hcl
1  terraform {
2    required_providers {
3      docker = {
4        source  = "kreuzwerker/docker"
5        version = "4.2.0"
6      }
7    }
8  }
```

This is the terraform code block. It specifies the provider(s) required for the configuration, here it is Docker, indicating that we want to use Terraform to manage Docker resources. The source section, line 4, identifies the Docker provider component to be downloaded during initialization, and line 5, indicates which version is required.

### Initializing the Provider

```hcl
10  provider "docker" {
11    host = "tcp://localhost:2375"
12  }
```

The provider block details parameters to be used when initializing the Docker provider. The configuration needed here is dependent upon the platform on which Docker is running. We are using Docker Desktop for Windows where the docker service is accessible using tcp port 2375.

### Pulling the Docker Image

```hcl
14  # Pull the image
15  resource "docker_image" "httpd" {
16    name = "httpd:latest"
17  }
```

This is one of two blocks of code that indicate the resources we want Terraform to instruct Docker to create. Here we are defining a docker image that needs to be pulled from Docker hub. Line 16 identifies the image we want, the latest version of “httpd”, an Apache webserver.

### Creating the Docker Container

```hcl
19  # Create a container
20  resource "docker_container" "webserver" {
21    image = docker_image.httpd.image_id
22    name  = "webserver"
23    ports {
24      internal = 80
25      external = 88
26    }
27  }
```

This is the second block of code that indicates the resources we want Terraform to instruct Docker to create. Here we are defining that we want docker to create a container called “web-server” (line22) and we want it to be accessible using ports 80 and 88 (lines 24-25). A docker container is created from a docker image. Line 21 indicates that the image to be used to create this container is the one we ask Docker to pull from Docker hub in lines 15-17. This is an example of one resource code block referencing another and it also indicates to Terraform that it must wait for Docker to download the image before it can ask it to create the container using it. This is known as implicit dependency; the container depends upon the image existing.

## Task2 Run Terraform & Test

1. In your IDE terminal, ensure you are in the correct working directory (C:\azurelabs\lab1)…

```powershell
cd c:\azurelabs\lab1
```

2. Run the terraform initialization command..

```powershell
terraform init
```
- Note the creation of a folder, '.terraform`, into which the Docker provider is downloaded


3. Now run the `terraform plan` command and review what will be created..

```powershell
terraform plan
```

4. Run `terraform apply`, typing `yes` when prompted.

```powershell
terraform apply
```

5. If prompted, Windows Defender should be configured to allow access

6. Switch to Docker Desktop and verify the image download and container creation.

7. Switch back to the VSC terminal and run `docker images`..

```powershell
docker images
```

The image listed is the httpd image that Terraform instructed Docker to download

8. Run `docker ps` to list running containers..

```powershell
docker ps
```

This is the container named ‘webserver’, that Terraform instructed Docker to start, using the downloaded image. Note the last few digits of the unique container ID for your running container.

9. Access the container via this link [http://127.0.0.1:88](http://127.0.0.1:88/)

10. View the “It Works" response from the Apache web server (index.html)

11. We will now modify the deployment by changing the external port number from 88 to 8088. Some resource changes can be applied to the existing instance of a resource, whilst others require the destruction of the original resource and the creation of a replacement. Let us see whether a port change modifies or recreates this resource.

12. Return to the `main.tf` file. Change the external port on line 25 from 88 to 8088.

```hcl
ports {
  internal = 80
  external = 8088
}
```

13. If you have not enabled Auto save, save the file changes using Ctrl+s

14. Run `terraform plan` again and review the changes. The change of port will force the current container to be deleted and a new one created…

```text
~ ports {
    ~ external = 88 -> 8088 # forces replacement
      # (3 unchanged attributes hidden)
  }

Plan: 1 to add, 0 to change, 1 to destroy.
```

15. Run `terraform apply`, typing `yes` when prompted

16. Browse to http://127.0.0.1:8088 This should return a success "It works" showing that the new container is listening on port 8088

17. Run `docker ps` again

Note that your CONTAINER ID will have changed – Docker containers are immutable so Terraform destroyed the original container and deployed a replacement using the same image. This is an important point to be aware of as we progress through the course. Whether we ‘update’ or ‘replace’ a resource when making changes depends upon the resource itself and the changes we make.

## Task3 Examine the state file

1. When `terraform apply` is run for the first time, a persistent record of resources Terraform deploys and manages is created in the form of a state file, `terraform.tfstate`. This file is updated whenever you ask Terraform to create, change, or destroy resources thereafter. By default this file will be in your working directory. Click on it now to examine its contents..

## Task4 Destroy the deployment

1. Run `terraform destroy`, review the output and type `yes`

2. Run `docker ps` to confirm your container has been deleted

3. Run `docker images` and confirm your image has been deleted

4. Revisit the state file and view its now reduced content

5. Quit Docker Desktop…

**Congratulations, you have completed this lab**

## Copyright

© 2026 QA Michael Coulling-Green. All rights reserved. These lab materials are provided as part of an authorised training course. Course attendees may reuse these materials for their own personal learning and reference outside of the training session. Unauthorised copying, redistribution, publication, or use of these materials to deliver training is prohibited without prior written permission from the author.
