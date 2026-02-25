#FROM rockylinux:9
FROM continuumio/miniconda3

RUN groupadd --gid 808 citeams-group
RUN useradd --gid 808 --uid 550 --create-home --password '$6$ouJkMasm5X8E4Aye$vahH2cHk4b8/TmzAcCxbkaraY84xyNFs.gqm/HWEykdngmOgELums1qOi3e6r8Z.asds7GEA9bObS/2pTN1WArGNf0' citeams

RUN apt-get update
RUN apt -y update


RUN apt -y install  \
     curl \
     gcc \
     emacs \
     nano \
     sudo \
     supervisor \
     tar \
     vim \
     wget

ADD ./docker/config/start.sh /start.sh
ADD ./docker/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# install jupyterlab using conda
# nodejs is required for jupyterlab
RUN conda install -c conda-forge nodejs ipykernel jupyterlab

# Locale and timezone
ENV LANG=en_US.UTF-8
RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Add the CITEAMS notebooks
ADD ./preliminaries /home/citeams/notebooks
RUN chown -R citeams /home/citeams/

# User setup
RUN echo -e "citeams ALL=(ALL)       NOPASSWD:ALL\n" >> /etc/sudoers
USER citeams

WORKDIR /home/citeams

# Set Kernel for Jupyter (exposes PATH and PYTHONPATH for use when terminal from jupyter is used)
ADD ./docker/config/kernel.json /usr/local/share/jupyter/kernels/python3/kernel.json
RUN echo -e "export PATH=/home/citeams/.pyenv/bin:\$PATH:/usr/lib64/mpich/bin" >> /home/citeams/.bashrc

# create the conda environemnt to use for citeams training
ADD ./docker/config/conda.yml /tmp/conda.yml
RUN conda env create -f /tmp/conda.yml

# register the environment mentioned in the conda.yml file
RUN ipython kernel install --user --name=citeams

USER root



CMD ["/start.sh"]


