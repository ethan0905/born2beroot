# 💻 born2beroot [![esafar's 42 Born2beroot Score](https://badge42.vercel.app/api/v2/cl6l739qg00490gialxmtgsrk/project/2202762)](https://github.com/JaeSeoKim/badge42)

**Raison pour lesquelles j'utilise Debian :**

- C'est un logiciel opensource
- C'est un système d'exploitation basé sous linux, sûr et fiable.
- Il possède plusieurs possibilités d'installation.
- Les maj sont douce et régulieres.

**Qu'est ce que Aptitude et quelle est la difference entre aptitude et apt ?**

- aptitude → gestionnaire de paquets qui peut également fonctionner comme apt-get et être utilisé en ligne de commande
- pourquoi aptitude ? en général, aptitude gère mieux les dépendances que apt-get. Par exemple, aptitude supprimera les paquets inutiles lors de la desinstallation d'un paquet.
- offre l'acces a toutes les versions d'un paquet
- enregistre toutes les actions dans /var/log/aptitude
- rend + facile le suivi des logiciels obsoletes
- systeme de recherches de paquets puissant
- aptitude integre su et peut etre utilisé par un utilisateur normal jusqu'a qu'il y'ait réellement besoin des privileges de l'administrateur

Qu'est ce que SELinux ?

- Security Enhenced Linux est une architecture de sécurité pour système linuxqui permet aux administrateurs de mieux controler les accès au système.

Comment cela fonctionne ? (cf cahier)

**Comment fonctionne AppArmor ?**

- Comme SELinux, sauf qu'au lieu d'identifier les objets systeme par leur nom, AppArmor les identifient via leur chemin.

Etapes CORRECTION :

**Preliminaires**

- [ ]  Etre present
- [ ]  Presence d'un fichier

**Instructions generales**

- [ ]  Aider le correcteur a faire les tests
- [ ]  fichier signature.txt a la racine du repo cloné
- [ ]  checker que la signature contenue dans signature.txt est identique
- [ ]  savoir ou se trouve le fichier .vdi
- [ ]  dupliquer la vm
- [ ]  demarrer la vm

**mandatory part**

project overview

- [ ]  Comment fonctionne une vm ?
- Une vm fonctionne comme un systeme informatique virtuel, avec son propre processeur, sa memoire, son interface reseau et son espace de stockage, mais qui est crée sur un système materiel physique
- [ ]  Pourquoi cet operating system?
- [ ]  Les differences basiques entre centOS et debian :
- [ ]  Quel est le but des machines virtuelles?
- [ ]  Difference entre aptitude et apt
- [ ]  Qu'est ce que AppArmor ?
- [ ]  Script crontab qui apparait toutes les 10 minutes

simple setup

- [ ]  pas d'environnement graphique au lancement
- [ ]  un mot de passe sera demandé avant de se connecter a la machine
- [ ]  se connecter avec un user (il ne devra pas etre un root)
- [ ]  faire attention au mot de passe choisi, il devra respecter les regles imposées par le sujet `sudo vim /etc/login.defs` et `sudo vim /etc/pam.d/common-password`
- [ ]  checker que service UFW est actif `sudo ufw`
- [ ]  checker que le service SSH est fonctionnel
- [ ]  checker que l'operating systeme choisi est bien debian `lsb_release -d` ou `uname -a`

user

- [ ]  le sujet demande qu'un user avec le login de l'etudiant évalué soit present sur la machine virtuelle. checker qu'il ait ete ajouté et qu'il appartienne a "sudo" et "user42" groups `sudo adduser login sudo` et `sudo groupadd nomdugroupe` `sudo adduser login user42` (pour supprimer un user ou un groupe, utiliser `deluser` ou `groupdel`) puis afficher avec `cat /etc/host`
- [ ]  s'assurer que les regles concernant la politique de mot de passe forte, ont bien ete mise en place, et ce, en suivant les etapes suivantes :
- [ ]  creer un nouvel user. `adduser login`
- [ ]  lui assigner un mdp de votre choix respectant les regles `sudo passwd login`
- [ ]  savoir expliquer comment on a set up ces regles `cd /etc/passwd`
- [ ]  demander a l'étudiant de creer un group appelé "evaluation" et de lui assigner le nouvel user créé `sudo groupadd evaluation`
- [ ]  checker que cet user appartient bien au groupe "evaluation" `cat /etc/groups | grep evaluation`
- [ ]  Quels sont les avantages de cette politique de mdp ?
- [ ]  Quels sont les avantages et desavantages de son implementation ?

hostname et partitions

- [ ]  checker que le hostname soit bien formaté comme suit : login42 (login of the student being evaluated) `hostnamectl`
- [ ]  modifier ce hostname en remplacant le login avec celui du correcteur, puis redemarrer la machine `sudo hostnamectl set-hostname login42` puis `sudo vim /etc/hosts`
- [ ]  vous pouvez maintenant restaurer le hostname originel `sudo reboot now`
- [ ]  montrer comment afficher la partition de la vm `lsblk`
- [ ]  comparer la output avec celle du sujet
- [ ]  Comment LVM fonctionne et de quoi s'agit-il ?
- C'est un gestionnaire de volume logique
- Il permet de réaliser des allocations dynamiques de mémoire, et donc, de bloquer uniquement la quantité de mémoire dont on a besoin (c'est du sur mesure)

sudo

- [ ]  checker que sudo soit bien installé `sudo apt-get update`
- [ ]  montrer comment assigner le nouvel user au groupe "sudo" `sudo adduser login sudo`
- [ ]  expliquer la valeur et le fonctionnement de sudo en utilisant un exemple de mon choix `sudo ufw status numbered`
- [ ]  montrer l'implementation des règles imposé par le sujet (code) `vim /etc/sudoers`
- [ ]  verifier que /var/log/sudo/ existe bien et possede au minimum un fichier `cd /var/log/sudo`
- [ ]  lancer une commande sudo et vérifier que /var/log/sudo/ se soit bien mis a jour `cat /var/log/sudo.log`

ufw

- [ ]  checker que UFW soit bien installé `sudo ufw`
- [ ]  checker qu'il fonctionne correctement
- [ ]  Qu'est ce que UFW et quel est l'intérêt de l'utiliser ?
- [ ]  lister les regles actives dans UFW : une regle doit exister pour le port 4242 `sudo ufw status numbered`
- [ ]  ajouter une nouvelle règle pour ouvrir le port 8080 `sudo ufw allow 8080`
- [ ]  enfin, supprimer cette règle `sudo ufw delete 3` (the number of the rule)

ssh

- [ ]  checker que le service ssh soit bien installé sur la vm `ssh`
- [ ]  checker qu'il fonctionne correctement `systemctl status ssh`
- [ ]  Qu'est ce que SSH et quel est l'intérêt de l'utiliser ?
- Secure SHell est un programme qui permet de communiquer des infos de maniere securisée, uniquement en début de connection (utilisation de clés de chiffrement)
- L'intérêt est que cela permet de sécuriser les transferts de donnés
- [ ]  verifier que ssh utilise seulement le port 4242 `sudo vim /etc/ssh/ssh_config`
- [ ]  utiliser ssh pour se connecter avec le nouvel user créé `ssh login@127.0.0.1 -p 4242`

script monitoring

- [ ]  expliquer comment fonctionne mon script
- [ ]  qu'est ce que cron ?
- crontab est un plannificateur de taches, qui permet notemment de lancer un script automatiquement tous les x temps.
- [ ]  comment set up le script pour qu'il se lance toutes les 10min ? `crontab -e`
- [ ]  lancer le script toutes les minutes `crontab -e` puis `*/1* * * * bash [monitoring.sh](http://monitoring.sh) | wall`
- [ ]  stopper l'execution du script sans toucher au script `crontab -e`

**BONUS**

- [ ]  set up de la partition (2points) `lsblk`
- [ ]  set up de wordpress (2 points) `localhost:8080/wordpress/`
- [ ]  set up libre de votre choix (1 point) webmin ([https://www.digitalocean.com/community/tutorials/how-to-install-webmin-on-debian-10](https://www.digitalocean.com/community/tutorials/how-to-install-webmin-on-debian-10))
- [ ]  comment fonctionne le systeme que j'ai choisi de setup et pourquoi est il pratique ?
- il simplifie l'administration des systemes linux et unix en permettant de realiser des taches comme : creer des comptes, installer un serveur web, configurer un serveur de messagerie etc... via une interface web, et en la mettant a jour en temps réel
- l'interface webmin est accessible a l'adresse suivante `https://adresseip:10000/`
