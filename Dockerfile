FROM ubuntu:20.04

### Configure default locale, see https://github.com/rocker-org/rocker/issues/19
#RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
#	&& locale-gen en_US.utf8 \
#	&& /usr/sbin/update-locale LANG=en_US.UTF-8

#ENV LC_ALL en_US.UTF-8
#ENV LANG en_US.UTF-8

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

RUN apt-get update

RUN apt-get install -y tzdata gpg-agent && \
    apt-get install -y --no-install-recommends software-properties-common dirmngr && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -sc)-cran40/" && \
    apt-get install -y --no-install-recommends r-base git

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