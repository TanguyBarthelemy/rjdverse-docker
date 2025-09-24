FROM rocker/r-ver:4.5.1

# Dépendances système pour Java & ProtoBuf
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    protobuf-compiler libprotobuf-dev libprotoc-dev \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN R CMD javareconf

# installer les packages R
RUN R -e "install.packages('renv', repos='https://cloud.r-project.org')"

RUN Rscript R/init-renv-lock.R
RUN R -e "renv::restore()"

WORKDIR /workspace

CMD ["R"]
