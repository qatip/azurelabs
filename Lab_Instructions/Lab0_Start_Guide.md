# QATIP Azure Lab0

## Environment Setup

Version 2.0.1 · 29/07/26 · mcgreen@qa.com

## Contents

- [Lab Objectives](#lab-objectives)
- [Teaching Points](#teaching-points)
- [Before you begin](#before-you-begin)
- [Task 1 Installing Class Files](#task-1-installing-class-files)
- [Task 2 Configuring your IDE](#task-2-configuring-your-ide)
- [Task 4 Logging into Azure for Terraform](#task-4-logging-into-azure-for-terraform)
- [Task 5 Arranging your remote desktop](#task-5-arranging-your-remote-desktop)
- [Copyright](#copyright)

## Lab Objectives

In this lab, you will:

- Launch your lab environment to access your virtual machine

- Download class files into your lab virtual machine

- Launch and configure Visual Studio Code (VSC) in your lab virtual machine ahead of running subsequent labs

## Teaching Points

This lab will set up your lab environment. It should be run at the beginning of the class before attempting any other labs. The lab environment has a time limit of 8 hours 30 minutes after which it will be decommissioned. At this point you will need restart the lab environment via the QA Portal to run this setup again.

## Before you begin

These instructions assume you have accessed the QA Portal and have followed the instructions provided there, starting/restarting the Azure lab environment… You should therefore have this screen in front of you before proceeding…

## Task 1 Installing Class Files

1. Expand the sidebar if needed and note down your Username, Password, Subscription ID and Random Suffix, as this information will be needed throughout the labs that follow. (Tip: Create a text document on the remote desktop). Collapse the sidebar once done.

2. In the remote VM, open an Admin PowerShell session.

3. Enter the following commands...

```powershell
cd\
git clone https://github.com/qatip/azurelabs.git
cd azurelabs
```

4. Close your Powershell session.

5. You can now open the course manual and lab instructions PDFs using a web browser within the remote desktop at c:\azurelabs…

## Task 2 Configuring your IDE

1. In the VM, open VSC using the desktop shortcut.

2. If required, change your colour scheme and Mark Done.

3. Close the getting started window.

4. On the left-hand vertical menu, choose the 5th Icon, Extensions (ctrl + Shift + x).

5. Search for Terraform.

6. Choose the terraform extension by Hashicorp and click install.

7. Once complete close the tab.

8. Navigate back to the top extension on the left-hand bar menu - EXPLORER

9. Open the labs folder; File, Open Folder, navigate to and select the C:\azurelabs folder. Select ‘yes’ to trust the authors of files in this folder.

10. Start a terminal session by selecting Terminal, New Terminal..

11. Close any ‘getting started’ files and you should now see your lab folders and have a terminal session open….

12. Optional: Enable Autosave: File, Autosave

13. As you perform each lab and execute commands in your terminal session, ensure that you move into the appropriate directory using the CD command, so when completing Lab1 for example; “cd c:\azure-tf-int\lab1”

## Task 4 Logging into Azure for Terraform

1. When required to run Terraform commands from the IDE terminal, you will need to authenticate to Azure unless you already have an active session.

2. Type “az login” in your terminal session

3. A dialog box should open, prompting you for credentials. Note: It may be obscured behind VSC if you have maximized.

4. Select ‘Work or school account’ and use the credential details found in the Portal labs details pane … Note: Use the provided password as your Temporary Access Pass

5. Select “No, this app only” for account use across multiple apps and websites.

6. Return to VSC and press enter to select the proposed subscription

7. If you experience any azure authentication issues during the course then simply run “az logout” followed by “az login” and follow the above procedure again.

8. Within the remote desktop, Open a web browser session and navigate to [https://azure.microsoft.com](https://azure.microsoft.com/)

9. Select “Sign In” and provide your lab credentials, again using the provided password as your Temporary Access Key

## Task 5 Arranging your remote desktop

1. In order to avoid the frustration of desktop clutter, it is suggested you arrange your desktop as shown below. In this way you can easily switch between your web browser, in which you can view your course manual, lab instructions, the Azure portal and any other web resources, and the VSC interface, in which you will create, and action terraform files. Alternatively, you can install the vscode-pdf extension into VSC which will then allow you to view PDFs within the IDE itself…

**Congratulations, you have completed this lab**

## Copyright

© 2026 QA Michael Coulling-Green. All rights reserved. These lab materials are provided as part of an authorised training course. Course attendees may reuse these materials for their own personal learning and reference outside of the training session. Unauthorised copying, redistribution, publication, or use of these materials to deliver training is prohibited without prior written permission from the author.
