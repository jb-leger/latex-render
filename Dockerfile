FROM debian:sid-slim
MAINTAINER Jean-Benoist Leger <jbleger@hds.utc.fr>

# Recreate non-existent directories
RUN mkdir -p /usr/share/man/man1 /usr/share/man/man2 /usr/share/man/man3 /usr/share/man/man4 /usr/share/man/man5 /usr/share/man/man6 /usr/share/man/man7 /usr/share/man/man8

RUN apt-get update

# Full Texlive distribution
RUN apt-get install -y --no-install-recommends \
        texlive-full \
        biber \
        fonts-opendyslexic \
        fonts-texgyre \
        fonts-liberation

# R dependencies
RUN apt-get install -y --no-install-recommends \
        r-base \
        r-cran-knitr \
        r-cran-xtable

# Conversion tools
RUN apt-get install -y --no-install-recommends \
        inkscape \
        pandoc

# PlantuUML dependencies
RUN apt-get install -y --no-install-recommends \
        default-jre \
        plantuml \
        graphviz

# Utils
RUN apt-get install -y --no-install-recommends \
        git \
        make \
        curl

# Installing pip and python-legacy modules
RUN apt-get install -y --no-install-recommends \
        python-pygments \
        python-matplotlib \
        python-numpy \
        python-scipy \
        python3-pip

# Python 3 utils
RUN pip3 install \
        pygments \
        matplotlib \
        numpy \
        scipy
        

# Locale
RUN apt-get install -y locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen
RUN echo "LC_ALL=fr_FR.UTF-8" >> /etc/profile
RUN echo "LANG=fr_FR.UTF-8" >> /etc/profile
RUN echo "export LC_ALL" >> /etc/profile
RUN echo "export LANG" >> /etc/profile

# Slim down image
RUN apt-get --purge -y remove tex.\*-doc$
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
