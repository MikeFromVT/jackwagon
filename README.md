# jackwagon
First repository built to support VNet-Riblett and RedTeamRSG on MS Azure virtual network.
These instructions are for building an automated ELK stack deployment.
The files in this repository were used to configure the network depicted below:

![ELK and VNet architecture](https://user-images.githubusercontent.com/48810057/112734448-ce1ba180-8f13-11eb-853c-826baf3707be.png)



These files have been tested and used to generate a live ELK deployment on MS Azure.
They cna be used to either recreate the entire deployment pictured above.
Aleternatively, select portions of the Ansible Playbook file may be used to install only certain pieces of it, such as Filebeat.


This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
-   Beats in Use
-     Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensure that the application will be highly available, in addition to restricting access to the network.
Load balancers play an importatnt role in protecting availability by protecting against Denial of Service attacks by off-loading traffic.

An advantage of a jump box is multi-fold.  They allow pushing or pulling to multiple computers (real or virtual) at the same time without having to log into each one singly.  They allow connection to machines that are dangerous (ie malware) due to where they are on the network and can be tailored for very specific access to minimize the risk.  Finally, they also allow an admin to jump into and out of multiple computers from a virtual space quickly and efficiently.

Integrating an ELK sever allows user to easily monitor the vulnerable VMs for changes to the data and system logs.  
The Filebeat monitors the log files or areas that you have specified.  The Filebeat also can collect log events and send them to the other parts of the Elastic stack: ElasticSearch or LogStash for manipulation.

Metricbeat takes the data it collects and sends it to the destination you specify, such as ElasticSearch or LogStash.

The configuration details of each machine may be found below.

|  Name 	                  | Function      	|   IP Address            	|   OS          	|
|-------------------------	|---------------	|-------------------------	|---------------	|
| Jump-Box-Provisioner    	| Gateway       	| 10.0.0.4 / 20.51.184.189	| Linux Ubuntu  	|
| Web-1                   	| DVSA web server	| 10.0.0.11               	| Linux Ubuntu  	|
| Web-2                   	| DVSA web server	| 10.0.0.12               	| Linux Ubuntu  	|
| Web-3                   	| DVSA web server	| 10.0.0.13               	| Linux Ubuntu   	|
| ELK-Rib                   | Elastic Stack   | 10.1.0.4 / 40.119.49.25   | Linux Ubuntu    |
| WebLoadBalIP              | Load Balancer   | 20.185.142.120            | Linux Ubuntu    |

![scrnsht all VMs used in Unit 13](https://user-images.githubusercontent.com/48810057/112734474-f86d5f00-8f13-11eb-8564-f0b900236d37.png)


### Access Policies

The machines on the internal network are not exposed to the public internet.

Only the Jump-Box-Provisioner machine can accept connections from the internet.  Access to this machine is only allowed from the following IP addresses:

199.119.147.225

Machines within the network can only be accessed by Jump-Box-Provisioner/Docker Container/elegant-germain or by coming through the WebLoadIP Load Balancer public IP.
The Jump-Box-Provisioner is ehitelisted available to 199.119.147.225 via ssh to port 22 to 20.51.184.189.  The Elastic Stack machine, ELK-Rib, can be accessed at 40.119.49.25 on port 5601 only by 199.119.147.225 due to firewall rules.

A Summary of the access policies in place can be found in the table below.

| Name                               | Publicly Available | Allowed IPv4 IP Addresses |
|------------------------------------|--------------------|---------------------------|
| Jump-Box-Provisioner               |  yes               | 20.51.184.189             |This
| Web-1                              |  no                | 10.0.0.11                 |
| Web-2                              |  no                | 10.0.0.12                 |
| Web-3                              |  no                | 10.0.0.13                 |
| ELK-Rib                            |  no                | 10.1.0.4                  |
| WebLoadIP                          |  no                | 23.96.22.147              |
|                                    |                    |                           |



### ELK configuration

Ansible was used with Docker container to automate configuration fo the ELK machine.  No configuration was performed manuall, which is advantageous because it's fast and simple, keeps me from having to write any code by using canned Ansible playbooks and Ansible will help figure out how to make sure the remote box is configured how I like.

The playbook implements the following tasks:
1. configure the ELK VM with Docker
2. increase the system memory size to 262144
3. install docker.io
4. install python3.pip
5. install docker 
6. expose the containers on ports: 5601, 9200, and 5044

The following screenshot displays the result of running "docker ps" after successfully configuring the ELK machine.

![image](https://user-images.githubusercontent.com/48810057/112733565-af66dc00-8f0e-11eb-8233-fb61aa638f89.png)

### Target Machines and Beats

This ELK server is configured to monitor the following machines: Web-1, Web-2, and Web-3.

We have installed the following beats on these machines:  FileBeat is installed on ELK-RIb, Web-1, -2, and  -3.

![scrnsht filebeat install via ansible success](https://user-images.githubusercontent.com/48810057/112733652-37e57c80-8f0f-11eb-8ed0-3af12b13e3b9.png)

![scrnsht filebeat data check after install](https://user-images.githubusercontent.com/48810057/112733661-42a01180-8f0f-11eb-9ab4-727f41e96b84.png)

This FileBeat install allows us to collect the following information from each machine: log events
Filebeat used as harvester for each file to monitor any change that occurs and if one does that is logged as an event and reported to Kibana.

### Using the playbook

In order to use the playbook, you will need to have and Ansible control node already configured.  Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- copy the cyberxsecurity/dvwa module into your yaml playbook file and update the filebeat-config file to include 10.1.0.4 (ELK-Rib)
- update hosts file to make sure all IPs are present for [web servers] and for [elk]
- run ansible-playbook install-elk.yml for ELK and ansible-playbook filebeat.yml for FileBeat
- run the playbook and navigate to the Kibana page and ensure there is data coming in from the logging

The playbook file is playbook.yml.
Hosts file must be updated to make Ansible run the playbook on a specific machine.  You specify by IP.
I specify which machine to install the ELK seever on by also using the hosts file but under [elk] header.
I go to http://40.119.49.25:5601/app/kibana to open Kibana and check to see if data is incoming.

![scrsht kibana connect after fw rule addition](https://user-images.githubusercontent.com/48810057/112734221-6022aa80-8f12-11eb-82e6-6d04bf8d47ba.png)






