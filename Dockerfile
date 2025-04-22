FROM rocker/shiny-verse:4.4.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends libcurl4-openssl-dev libarchive-dev \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /srv/shiny-server \
    && install2.r DT duckdb factoextra GGally ggpubR ggVennDiagram httpuv leaflet shinyBS shinylive shinyjs shinyWidgets

RUN rm -rf /srv/shiny-server
COPY app/ /srv/shiny-server

WORKDIR /srv/shiny-server/

RUN Rscript -e "shinylive::export(appdir = '.', destdir = 'docs')" \
    && chown --recursive shiny:shiny /srv/shiny-server/

