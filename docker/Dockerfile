FROM rockylinux:9

RUN groupadd --gid 808 citeams-group
RUN useradd --gid 808 --uid 550 --create-home --password '$6$ouJkMasm5X8E4Aye$vahH2cHk4b8/TmzAcCxbkaraY84xyNFs.gqm/HWEykdngmOgELums1qOi3e6r8Z.asds7GEA9bObS/2pTN1WArGNf0' citeams

RUN dnf -y update && \
    dnf -y install 'dnf-command(config-manager)' && \
    dnf -y config-manager --set-enabled devel && \
    dnf -y config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf -y install epel-release

RUN dnf -y install --allowerasing --nobest \
     curl \
     gcc \
     docker-ce \
     emacs \
     glibc-langpack-en \
     graphviz \
     java-11-openjdk-devel \
     langpacks-en \
     nano \
     python3-devel \
     python3-GitPython \
     python3-pip \
     sudo \
     supervisor \
     tar \
     vim \
     emacs \
     wget

ADD ./docker/config/start.sh /start.sh
ADD ./docker/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# Python packages
# argon2-cffi-bindings which jupyter requires has a requirements for setuptools_scm>=6.2
RUN python3 -m pip install 'setuptools_scm>=6'
RUN python3 -m pip install jupyter

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

USER root
CMD ["/start.sh"]


