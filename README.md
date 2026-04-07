# 🚀 Automated Infrastructure Deployment using Shell Scripting & Cron Jobs

## 📌 Overview

* This project automates the provisioning and management of cloud infrastructure using Shell Scripting, Cron Jobs, and Terraform on AWS.
* It eliminates manual intervention by scheduling infrastructure deployment and updates at predefined intervals.

## 🎯 Objectives

* Automate infrastructure provisioning using scripts
* Schedule deployments and updates using cron jobs
* Ensure consistent and repeatable infrastructure setup
* Reduce manual errors and operational overhead

## 🛠️ Technologies Used

* Linux
* Shell Scripting (Bash)
* Cron Jobs
* Terraform
* AWS (Amazon Web Services)

## 📈 Future Enhancements

* Add monitoring using CloudWatch
* Integrate CI/CD pipelines (GitHub Actions / Jenkins)
* Add alerting for failed deployments
* Implement infrastructure testing

## Run deployment every day at 2 AM
0 2 * * * /home/ubuntu/main.sh >> /home/ubuntu/new1.log

##📊 Logging & Monitoring

Explain briefly: Logs are stored in the logs/ directory. Each execution records success/failure status and timestamps.
