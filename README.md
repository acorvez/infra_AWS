# Infrastructure AWS avec Terraform et Ansible

Ce projet contient les scripts Terraform et Ansible pour déployer une infrastructure complète sur AWS, comprenant un VPC, EKS, RDS, EFS, et divers services comme Keycloak, OpenLDAP, Prometheus, Grafana, Loki, et plus encore.

## Architecture

L'architecture déployée correspond au diagramme fourni et comprend les composants suivants :

- **VPC** avec sous-réseaux publics et privés
- **EKS** (Elastic Kubernetes Service) pour l'orchestration des conteneurs
- **ALB** (Application Load Balancer) pour l'exposition des services
- **VPN** pour l'accès sécurisé à l'infrastructure
- **RDS** (Relational Database Service) pour les bases de données
- **EFS** (Elastic File System) pour le stockage partagé
- **Keycloak** pour la gestion des identités et des accès
- **OpenLDAP** pour l'annuaire d'utilisateurs
- **CephFS** pour le stockage distribué
- **Prometheus, Grafana, Loki** pour la surveillance
- **Bind9** pour la résolution DNS
- **Consul** pour la découverte de services
- **Flux CD** pour le GitOps

## Prérequis

- AWS CLI configuré avec les autorisations nécessaires
- Terraform v1.0.0 ou supérieur
- Ansible v2.10 ou supérieur
- kubectl
- jq
- Git
- OpenVPN (pour se connecter au VPN)

## Structure du projet

```
.
├── ansible/
│   ├── files/
│   ├── tasks/
│   ├── vars/
│   ├── deploy.yml
│   └── inventory.ini
├── terraform/
│   ├── modules/
│   │   ├── alb/
│   │   ├── efs/
│   │   ├── eks/
│   │   ├── rds/
│   │   ├── security/
│   │   ├── vpc/
│   │   └── vpn/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
└── Makefile
```

## Déploiement

### Configuration

1. Modifiez le fichier `terraform.tfvars` avec vos propres valeurs.
2. Assurez-vous que votre AWS CLI est correctement configuré avec les autorisations nécessaires.

### Déploiement complet

Pour déployer l'infrastructure complète, exécutez :

```bash
make deploy_infra
```

Cette commande va :
1. Initialiser Terraform
2. Déployer l'infrastructure AWS avec Terraform
3. Configurer le cluster EKS
4. Déployer tous les services avec Ansible

### Commandes individuelles

Vous pouvez également exécuter les étapes individuellement :

```bash
# Initialiser Terraform
make init

# Planifier les changements Terraform
make plan

# Appliquer les changements Terraform
make apply

# Déployer uniquement EKS
make deploy_eks

# Nettoyer les fichiers temporaires
make clean

# Détruire l'infrastructure
make destroy
```

## Connexion au VPN

Après le déploiement, un fichier de configuration OpenVPN sera généré dans `ansible/files/vpn/`. Pour vous connecter au VPN, exécutez :

```bash
./ansible/files/vpn/connect-vpn.sh
```

## Accès aux services

Une fois connecté au VPN, vous pouvez accéder aux services suivants :

- Keycloak: https://auth.example.com
- Grafana: https://grafana.example.com
- phpLDAPadmin: https://phpldapadmin.example.com
- Consul: https://consul.example.com

Remplacez `example.com` par le domaine configuré dans vos variables.

## Surveillance et journalisation

- **Prometheus** collecte les métriques de tous les services
- **Grafana** visualise les métriques de Prometheus
- **Loki** centralise les journaux de tous les services

## Sécurité

Cette infrastructure est conçue avec une approche de sécurité en couches :

- Accès au VPC uniquement via VPN
- Services critiques dans des sous-réseaux privés
- Groupes de sécurité restrictifs
- Authentification centralisée avec Keycloak

## Maintenance et mises à jour

Pour mettre à jour l'infrastructure, modifiez les fichiers Terraform ou Ansible selon vos besoins, puis réexécutez les commandes de déploiement.

Pour les applications déployées avec Flux CD, poussez simplement vos changements vers le dépôt Git configuré, et Flux CD les appliquera automatiquement.

## Nettoyage

Pour supprimer toute l'infrastructure, exécutez :

```bash
make destroy
```

**Attention** : Cette commande supprimera toutes les ressources déployées, y compris les données persistantes.

## Contribution

1. Forkez le projet
2. Créez votre branche de fonctionnalité
3. Committez vos changements
4. Poussez vers la branche
5. Ouvrez une Pull Request

## Licence

Ce projet est distribué sous licence MIT.