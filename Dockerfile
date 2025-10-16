FROM inseefrlab/onyxia-rstudio:4.5.1

# Dépendances système pour Java & ProtoBuf
RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    protobuf-compiler libprotobuf-dev libprotoc-dev \
	libcairo2-dev \
	libharfbuzz-dev libfribidi-dev \
	libgit2-dev libssh2-1-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*

ARG GITHUB_PAT

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV GITHUB_PAT=${GITHUB_PAT}

RUN R CMD javareconf

WORKDIR ${HOME}/work

# Installer les packages R
COPY renv.lock .
RUN Rscript -e "renv::restore(library = file.path(Sys.getenv('HOME'), 'renv', 'library'))"

RUN chown -R onyxia ${HOME}
