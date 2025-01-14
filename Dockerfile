# Utilisez l'image Ubuntu officielle comme base
FROM ubuntu:20.04

# Mettre à jour et installer les dépendances essentielles
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    sudo \
    wget \
    curl \
    gnupg2 \
    lsb-release \
    ca-certificates \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    protobuf-compiler \
    libprotobuf-dev \
    libprotoc-dev \
    software-properties-common \
    apt-transport-https

# Installer OpenJDK 17
RUN apt-get install -y openjdk-17-jdk

# Ajouter les dépôts CRAN pour R
RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" | tee -a /etc/apt/sources.list

# Ajouter la clé GPG pour les dépôts CRAN
RUN curl -fsSL https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee /etc/apt/trusted.gpg.d/marutter.asc

# Installer R 4.4.2
RUN apt-get update && apt-get install -y r-base

# Vérifier les versions installées
RUN java -version && R --version

# Installer ProtoBuf (si ce n'est pas déjà installé avec apt)
RUN apt-get install -y protobuf-compiler libprotobuf-dev libprotoc-dev

# Définir un répertoire de travail
WORKDIR /workspace

# Exposer le port si nécessaire (optionnel)
# EXPOSE 8787

# Lancer un shell par défaut (vous pouvez remplacer cela par une commande spécifique si vous en avez besoin)
CMD ["/bin/bash"]
