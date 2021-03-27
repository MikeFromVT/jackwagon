# jackwagon
First repository built to support VNet-Riblett and RedTeamRSG on MS Azure virtual network.
These instructions are for building an automated ELK stack deployment.
The files in this repository were used to configure the network depicted below:

https://github.com/MikeFromVT/jackwagon/blob/main/Net%20Diag%20Unit%2013%20w%20ELK%20Stack.drawio

These files have been tested and used to generate a live ELK deployment on MS Azure.
They cna be used to either recreate the entire deployment pictured above.
Aleternatively, select portions of the Ansible Playbook file may be used to install only certain pieces of it, such as Filebeat.

##insert ansiible file here##
This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
-   Beats in Use
-     Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensure that the application witll be highly available, in addition to restricting access to the network.

