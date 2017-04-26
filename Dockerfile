FROM jeanim/mayabase-centos

MAINTAINER jeanimator@gmail.com

# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
RUN wget http://download.autodesk.com/us/maya/service_packs/Autodesk_Maya_2013_SP1_English_Linux_64bit.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz && \
    rpm -Uvh /maya/Maya*.rpm && \
    rm -r /maya

RUN echo alias hpython="\"/usr/autodesk/maya/bin/mayapy\"" >> ~/.bashrc && \
    echo alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Setup environment
ENV MAYA_LOCATION=/usr/autodesk/maya/
ENV PATH=$MAYA_LOCATION/bin:$PATH
ENV PYTHONPATH=/usr/lib/python2.6/site-packages

# Install pip manually
# `mayapy get-pip.py` throws an error: "__init__() keywords must be strings"
# which looks to be a Python 2.6-specific error. A similar problem was found
# here: https://github.com/rg3/youtube-dl/issues/3813
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python2.6 get-pip.py

RUN pip install \
 nose \
 mock

# Cleanup
WORKDIR /root
