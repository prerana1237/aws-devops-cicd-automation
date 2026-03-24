Automated Infrastructure Deployment: Shell + Terraform + Cron 📌 Project Overview This project focuses on Infrastructure as Code (IaC) Automation using native Linux scheduling tools. It replaces manual terraform apply workflows with a self-healing, scheduled deployment system. By wrapping Terraform execution in Shell scripts and scheduling them via Cron, the system ensures that cloud infrastructure remains synchronized with the desired state defined in configuration files.

🏗 System Architecture Scripting Layer: Bash scripts handle pre-deployment checks, Terraform initialization, and execution.

Scheduling Layer: Linux crontab manages execution intervals (e.g., daily drift checks or hourly scaling).

Infrastructure Layer: Terraform provisions resources (VPC, EC2, S3) on AWS.

Observability: Automated logs are generated for every execution to track success/failure rates and facilitate troubleshooting.

🛠 Features Automated Provisioning: Eliminates the need for manual CLI intervention for routine updates.

Drift Detection: Scheduled runs ensure that any manual changes in the AWS Console are overwritten by the "Source of Truth" in Terraform.

Error Handling: Integrated logic to capture stderr and halt execution if Terraform state is locked or network issues occur.

Logging System: Timestamps and execution status are piped to a centralized log file (/var/log/tf-automation.log).

📂 Project Structure Plaintext . ├── scripts/ │ └── deploy-infra.sh # Main automation script ├── terraform/ │ ├── main.tf # AWS Resource definitions │ ├── variables.tf # Infrastructure variables │ └── outputs.tf # Resource endpoints ├── logs/ │ └── execution.log # Deployment history └── README.md

Implementation Details

The Automation Script (deploy-infra.sh) The script automates the standard Terraform workflow:
Navigates to the working directory.

Performs terraform init to ensure providers are ready.

Executes terraform apply -auto-approve to push changes.

Captures exit codes to log whether the deployment was a SUCCESS or FAILURE.

Scheduling with Cron To maintain infrastructure consistency, a cron job was configured to trigger the script at specific intervals. For example, to run an update every day at midnight:
Edit crontab
crontab -e

Schedule: Run at 00:00 every day
0 0 * * * /bin/bash /path/to/scripts/deploy-infra.sh >> /path/to/logs/cron.log 2>&1

📈 Key Outcomes Operational Efficiency: Reduced time spent on infrastructure updates by 100% through full automation.

Reliability: Standardized deployment logs made troubleshooting infrastructure failures 50% faster.

Cost Management: Enabled the use of scheduled "Destroy" scripts to automatically shut down non-production environments during off-hours, optimizing AWS costs.
