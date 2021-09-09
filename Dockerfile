FROM tercen/runtime-r40:4.0.4-1

ENV RENV_VERSION 0.13.0
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cran.r-project.org'))"
RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"


WORKDIR /operator

RUN git clone https://github.com/tercen/mean_operator

WORKDIR /operator/mean_operator

RUN echo 0.12.0-R4 && git pull
RUN git checkout 0.12.0-R4

RUN R  --vanilla -e "renv::restore(confirm=FALSE)"

ENV TERCEN_SERVICE_URI https://tercen.com

ENTRYPOINT [ "R","--no-save","--no-restore","--no-environ","--slave","-f","main.R", "--args"]
CMD [ "--taskId", "someid", "--serviceUri", "https://tercen.com", "--token", "sometoken"]