FROM continuumio/miniconda3

# base image is debian with default shell as sh
SHELL ["/bin/bash", "-c"]

# variables to be used in docker build
ARG CITEAMS_USER=citeams
ARG CONDA_ENV_NAME=citeams

RUN groupadd --gid 808 citeams-group
RUN useradd -s /bin/bash --gid 808  --create-home --password '$6$ouJkMasm5X8E4Aye$vahH2cHk4b8/TmzAcCxbkaraY84xyNFs.gqm/HWEykdngmOgELums1qOi3e6r8Z.asds7GEA9bObS/2pTN1WArGNf0' $CITEAMS_USER && \
    usermod -s /bin/bash $CITEAMS_USER
ENV SHELL=/bin/bash    

RUN apt-get update
RUN apt -y update


RUN apt -y install  \
     locales \
     curl \
     gcc \
     emacs \
     nano \
     sudo \
     supervisor \
     tar \
     vim \
     wget

ADD ./config/start.sh /start.sh
ADD ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# install jupyterlab using conda
# nodejs is required for jupyterlab
# ipympl is required for interactive widgets
RUN conda install -y -c conda-forge nodejs jupyterlab
#ipympl jupyterlab_widgets ipywidgets

# not required for jupyter version greater than 3
#RUN jupyter labextension enable ipympl ipywidgets


# Locale and timezone
ENV LANG=en_US.UTF-8
RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN echo "en_US.UTF-8 UTF-8" | tee -a /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# User setup
RUN chown -R $CITEAMS_USER /home/$CITEAMS_USER/
RUN echo -e "$CITEAMS_USER ALL=(ALL)       NOPASSWD:ALL\n" >> /etc/sudoers

# Set Kernel for Jupyter (exposes PATH and PYTHONPATH for use when terminal from jupyter is used)
ADD ./config/kernel.json /usr/local/share/jupyter/kernels/python3/kernel.json

# create the conda environment to use for citeams training
ADD ./config  /tmp/config
#ADD ./config/hyperspy_tools /tmp/hyperspy_tools-0.1.2-py3-none-any.whl /tmp/hyperspy_tools-0.1.2-py3-none-any.whl
#ADD ./config/hyperspy_tools_requirements.txt /tmp/hyperspy_tools_requirements.txt
RUN conda env create -n $CONDA_ENV_NAME -f /tmp/config/conda.yml
RUN conda clean -y --all

# create a jupyter kernel for environment mentioned in the conda.yml file
RUN conda run -n $CONDA_ENV_NAME python3 -m ipykernel install --name=$CONDA_ENV_NAME --display-name="Python ($CONDA_ENV_NAME)"

CMD ["/start.sh"]


