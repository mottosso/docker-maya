FROM mottosso/mayabase-centos
 
MAINTAINER marcus@abstractfactory.io
 
# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
RUN wget http://download.autodesk.com/us/maya/service_packs/Autodesk_Maya_2013_SP1_English_Linux_64bit.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz

# Install Maya
RUN rpm -Uvh /maya/Maya*.rpm && \
    rm -rf /maya

# Make mayapy the default Python
RUN rm -f /usr/bin/python && \
    echo alias python="\"/usr/autodesk/maya/bin/mayapy\"" >> ~/.bashrc

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

RUN python2.6 -m pip install \
 nose

# Cleanup
WORKDIR /root
