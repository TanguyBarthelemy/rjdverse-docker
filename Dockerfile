FROM rocker/r-ver:4.5.1

# Dépendances Java et ProtoBuf
RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    protobuf-compiler \
    libprotobuf-dev \
    libprotoc-dev \
    curl \
    git \
    build-essential \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN R CMD javareconf

# installer les packages R
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

WORKDIR /workspace
COPY renv.lock renv.lock

RUN R -e "renv::restore()"

CMD ["R"]
