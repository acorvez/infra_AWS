.PHONY: all init plan apply destroy deploy_eks deploy_infra clean help

# Variables
TF_VAR_FILE ?= terraform.tfvars
ANSIBLE_INVENTORY ?= ansible/inventory.ini
AWS_REGION ?= eu-west-1
ENV ?= dev

help:
	@echo "Commandes disponibles:"
	@echo "  make init        - Initialiser Terraform"
	@echo "  make plan        - Planifier les changements Terraform"
	@echo "  make apply       - Appliquer les changements Terraform"
	@echo "  make destroy     - Détruire l'infrastructure Terraform"
	@echo "  make deploy_eks  - Déployer uniquement EKS"
	@echo "  make deploy_infra - Déployer l'infrastructure complète (Terraform + Ansible)"
	@echo "  make clean       - Nettoyer les fichiers temporaires"
	@echo "Options:"
	@echo "  TF_VAR_FILE=fichier.tfvars - Spécifier un fichier de variables Terraform"
	@echo "  ANSIBLE_INVENTORY=fichier.ini - Spécifier un inventaire Ansible"
	@echo "  AWS_REGION=region - Spécifier la région AWS"
	@echo "  ENV=environnement - Spécifier l'environnement (dev, staging, prod)"

all: deploy_infra

init:
	@echo "Initialisation de Terraform..."
	cd terraform && terraform init

plan:
	@echo "Planification des changements Terraform..."
	cd terraform && terraform plan -var-file=$(TF_VAR_FILE)

apply:
	@echo "Application des changements Terraform..."
	cd terraform && terraform apply -var-file=$(TF_VAR_FILE) -auto-approve

destroy:
	@echo "Destruction de l'infrastructure..."
	cd terraform && terraform destroy -var-file=$(TF_VAR_FILE) -auto-approve

deploy_eks: apply
	@echo "Extraction des informations du cluster EKS..."
	cd terraform && \
		terraform output -json > ../output.json && \
		export EKS_CLUSTER_NAME=`jq -r '.eks_cluster_name.value' ../output.json` && \
		export EKS_CLUSTER_ENDPOINT=`jq -r '.eks_cluster_endpoint.value' ../output.json` && \
		export VPC_ID=`jq -r '.vpc_id.value' ../output.json` && \
		export EFS_ID=`jq -r '.efs_id.value' ../output.json` && \
		export EFS_DNS_NAME=`jq -r '.efs_dns_name.value' ../output.json` && \
		export RDS_ENDPOINT=`jq -r '.rds_endpoint.value' ../output.json` && \
		export VPN_ENDPOINT_ID=`jq -r '.vpn_endpoint_id.value' ../output.json` && \
		export VPN_ENDPOINT_DNS=`jq -r '.vpn_endpoint_dns_name.value' ../output.json` && \
		export ALB_DNS_NAME=`jq -r '.alb_dns_name.value' ../output.json` && \
		aws eks update-kubeconfig --name $$EKS_CLUSTER_NAME --region $(AWS_REGION)

deploy_infra: deploy_eks
	@echo "Déploiement des applications avec Ansible..."
	export ANSIBLE_HOST_KEY_CHECKING=False && \
		cd ansible && \
		ansible-playbook -i $(ANSIBLE_INVENTORY) deploy.yml

clean:
	@echo "Nettoyage des fichiers temporaires..."
	rm -f output.json
	rm -rf terraform/.terraform
	rm -f terraform/.terraform.lock.hcl
	rm -f terraform/terraform.tfstate*