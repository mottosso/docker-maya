FROM mottosso/mayabase-centos
 
MAINTAINER marcus@abstractfactory.io
 
# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
RUN wget http://download.autodesk.com/us/support/files/maya_2015_service_pack_3/Autodesk_Maya_2015_SP3_English_Linux.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz

# Install Maya
RUN rpm -Uvh /maya/Maya*.rpm && \
    rm -r /maya

# Make mayapy the default Python
RUN rm -f /usr/bin/python && \
    echo alias python=/usr/autodesk/maya/bin/mayapy >> ~/.bashrc

# Setup environment
ENV MAYA_LOCATION=/usr/autodesk/maya2015-x64/
ENV PATH=$MAYA_LOCATION/bin:$PATH

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    mayapy get-pip.py

RUN mayapy -m pip install \
 nose

# Cleanup
WORKDIR /root