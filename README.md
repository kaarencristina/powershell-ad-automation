# PowerShell AD Automation

A collection of PowerShell scripts for automating common Active Directory
administrative tasks in a Windows Server lab environment.

## Project Overview

This project was created to practise Active Directory administration and
PowerShell automation in a virtualised Windows Server environment.

The project focuses on automating repetitive administrative tasks such as:

- Creating Organizational Units (OUs)
- Creating Active Directory users
- Creating security groups
- Assigning users to department groups
- Organising users within the appropriate OUs
- Checking whether objects already exist before creating them

## Lab Environment

- Windows Server 2022
- Active Directory Domain Services
- PowerShell
- Active Directory PowerShell Module
- VirtualBox
- Domain: `techsolutions.local`

## Active Directory Structure

The lab contains the following departments:

```text
Departments
├── Finance
├── HR
├── IT
├── Marketing
├── Operations
└── Sales
