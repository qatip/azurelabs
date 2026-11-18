# QATIP Azure Lab0

## Environment Setup
Last reviewed and tested - 18/11/26 17:24 - mcgreen@qa.com

PDF version deprecated and removed due to copy/paste issues.


## Lab Objectives

In this lab, you will:

- Launch your lab environment through platform.qa.com and access your lab virtual machine

- Ensure class files are available and current on your lab virtual machine

- Launch and configure Visual Studio Code (VSC) on your lab virtual machine ahead of running subsequent labs

## Teaching Points

This lab will set up your lab environment. It should be run at the beginning of the class before attempting any other labs. The lab environment has a time limit of 8 hours 30 minutes after which it will be decommissioned. At this point you will need restart the lab environment via the QA Portal to run this setup again.

## Before you begin

These instructions assume you have logged into platform.qa.com and have followed the instructions provided there, starting/restarting the Azure lab environment. After a short period of set-up, a remote desktop will load and a side-bar displayed.

## Task 1 Verify Class Files are Present and Current.

1. From the side-bar, note down your `Username`, `Password`, `Subscription ID` and `Random Suffix`, as this information will be needed throughout the labs that follow. (Tip: Create a text document on the remote desktop). Collapse the sidebar once done.

2. `Do not` press the `Submit` button in the side-bar unless you wish to end the entire lab environment. Doing so will destroy any resources created as well as the provisioned desktop. Once the current lab environment has ended, you are free to restart a new session for another 8hr 30mins but you will be provided with new credentials and a fresh desktop each time, so re-run this lab again. Access to this lab environment extends to two weeks from the course start date, it is not limited to class hours/duration.

2. In the remote VM, open a PowerShell session. (Right-click over the Windows logo and select 'Terminal')

3. Enter the following commands...

```powershell
cd c:\azurelabs
git config --global --add safe.directory C:/azurelabs
git pull
```

4. If you receive an error message stating that the folder cannot be found then enter the following..

```powershell
cd c:\
git clone https://github.com/qatip/azurelabs.git
```

5. Close your Powershell session.

## Task 2 Configuring your IDE

1. In the VM, open Visual Studio Code (VSC) using the desktop shortcut.

2. If required, change your colour scheme and Mark Done.

3. Close any "Getting Started" tabs that may appear.

4. On the left-hand vertical menu, choose the 5th Icon, Extensions (ctrl + Shift + x).

5. Search for `Terraform`.

6. Choose the Terraform extension `by Hashicorp` and click install.

7. Once complete close the tab.

8. Navigate back to the top extension on the left-hand bar menu - EXPLORER

9. If the lab folder is not currently displayed then open it; File, Open Folder, navigate to and select the C:\azurelabs folder. Select ‘yes’ to trust the authors of files in this folder if prompted.

10. Start a terminal session by selecting "Terminal", "New Terminal".

11. Optional (but recommended): Enable Autosave: File, Autosave

12. As you perform each lab and execute commands in your terminal session, ensure that you move into the appropriate directory using the `cd` command, so when completing Lab1 for example..

```powershell
cd c:\azurelabs\lab1
```

13. Lab instructions are at c:\azurelabs\lab_instructions. Use VSC Explorer to navigate to the appropriate lab instructions markdown (md) file. Right click and choose 'Open Preview'

## Task 3 Logging into Azure for Terraform

1. When required to run Terraform commands from the IDE terminal, you will need to authenticate to Azure unless you already have an active session.

2. Type `az login` in your terminal session

3. A dialog box should open, prompting you for credentials. Note: It may be obscured behind VSC if you have it maximized.

4. Select `Work or school account` and use the credential details you noted down earlier. Note: Use the provided `password` as your `Temporary Access Pass`

5. Select `No, this app only` for account use across multiple apps and websites.

6. Return to VSC and press enter to select the proposed subscription

7. If you experience any azure authentication issues during the course then simply run `az logout` followed by `az login` and follow the above procedure again.

8. Within the remote desktop, Open a web browser session and navigate to [https://azure.microsoft.com](https://azure.microsoft.com/)

9. Select `Sign In` and provide your lab credentials, again using the provided password as your Temporary Access Key

**Congratulations, you have completed this lab**

## Copyright

© 2026 QA Michael Coulling-Green. All rights reserved. These lab materials are provided as part of an authorised training course. Course attendees may reuse these materials for their own personal learning and reference outside of the training session. Unauthorised copying, redistribution, publication, or use of these materials to deliver training is prohibited without prior written permission from the author.
