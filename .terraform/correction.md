# Correction
## Terraform
### Providers
- **mirage** : dl cloud.yaml et le placer dans le dossier du projet
- terraform init

### Network
- create network.tf
- data recup des données
- resource : creer something
- terraform apply (yes)

### Instances
- machine + floating ip
- flavor : (m2.v2.d10)
- config_drive = true
- network : connecter celui qu'on a créé

### images
- name
- tag

### IP
- pool = public

### associer l'ip

- floating_ip = celle qu'on a créé
- instance_id = celle qu'on a créé

- terraform apply

#### pb : créé mais pas config la machine
### solu 
- créer cloud-init
- au lieu de password on met ssh_authorized_keys et on met la notre
- dans instance on met : user_data = file(".cloud-init.yml) (qui s'execute qu'a la creation de la machine)
#### cant connect yet 

### solu creer groupe de secu
- secugroupe_v2
- description 
### creer les regles 
- secgroupe_rule
- ingress de l'exterieur vers la machine (ingress entrant et egress pour sortant)
- 0.0.0.0/0
- add dans l'instance le groupe de secu
- terraform apply

## Vars
- dans var on crée un tab names = ["", ""]
- count (useful pr plusieurs machines) : length(var.names)

## CIDR
192.168.1.0/24 (means on ne peut pas toucher aux 24 premiers bits so les 8 derniers peuvent changer)