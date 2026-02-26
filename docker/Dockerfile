#FROM rockylinux:9
FROM continuumio/miniconda3

RUN groupadd --gid 808 citeams-group
RUN useradd -s /bin/bash --gid 808  --create-home --password '$6$ouJkMasm5X8E4Aye$vahH2cHk4b8/TmzAcCxbkaraY84xyNFs.gqm/HWEykdngmOgELums1qOi3e6r8Z.asds7GEA9bObS/2pTN1WArGNf0' citeams

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
RUN conda install -y -c conda-forge nodejs jupyterlab

# Locale and timezone
ENV LANG=en_US.UTF-8
RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Add the CITEAMS notebooks
ADD ./preliminaries /home/citeams/notebooks
RUN chown -R citeams /home/citeams/

# User setup
RUN echo -e "citeams ALL=(ALL)       NOPASSWD:ALL\n" >> /etc/sudoers

# Set Kernel for Jupyter (exposes PATH and PYTHONPATH for use when terminal from jupyter is used)
ADD ./docker/config/kernel.json /usr/local/share/jupyter/kernels/python3/kernel.json

# create the conda environment to use for citeams training
ENV CONDA_ENV_NAME=citeams
ADD ./docker/config/conda.yml /tmp/conda.yml
RUN conda env create -n $CONDA_ENV_NAME -f /tmp/conda.yml

# create a jupyter kernel for environment mentioned in the conda.yml file
RUN conda run -n $CONDA_ENV_NAME python -m ipykernel install --name=citeams --display-name="Python ($CONDA_ENV_NAME)"

CMD ["/start.sh"]


