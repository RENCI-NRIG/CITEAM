## Instructions on building the wheel package

1. checkout the github repository
git checkout https://github.com/jat255/hyperspy_tools.git

2. run a vanilla python container
cd ./hyperspy_tools
docker run -it --bind .:/srv --rm python:3.13 /bin/bash

3. now you are inside the container.  install setup tools
pip3 install setuptools

4. edit setup.py and replace PyQt4 with PyQt5
 in the requires section
                 #'PyQt4>=4.11.3',
                 'PyQt5',

5. build the wheel
python3 setup.py sdist bdist_wheel

6. wheel can be found at /srv/dist also the git checkout directory
root@92220bb3a6e4:/srv/dist# ls -lht /srv/dist/hyperspy_tools-0.1.2-py3-none-any.whl