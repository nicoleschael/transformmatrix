# =====================================================================
# Dockerfile - immagine con R + la funzione mattransform
# Costruisci (da questa cartella):  docker build -t matrixtransform:latest .
# =====================================================================

FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# installa R e gli strumenti di compilazione
RUN apt-get update && apt-get install -y --no-install-recommends \
    r-base r-base-dev build-essential

# le librerie R necessarie alla funzione
RUN Rscript -e "install.packages('Matrix', repos='https://cloud.r-project.org')"
RUN Rscript -e "install.packages('data.table', repos='https://cloud.r-project.org')"

# copia la funzione dentro l'immagine
COPY mattransform.R /home/mattransform.R
RUN chmod 644 /home/mattransform.R

# pulizia (riduce la dimensione dell'immagine)
RUN rm -rf /var/lib/apt/lists/*
