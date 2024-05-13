FROM rocker/verse:latest
# Enable github copilot
RUN echo 'copilot-enabled=1' >> /etc/rstudio/rsession.conf

# Install additional R packages
RUN Rscript -e "install.packages(c(\
  'geoR'\
  ), repos='https://cran.rstudio.com')"
