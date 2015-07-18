FROM mottosso/mayabase-centos
 
MAINTAINER marcus@abstractfactory.io
 
# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
RUN wget http://download.autodesk.com/us/support/files/maya_2014_SP3/Autodesk_Maya_2014_SP3_English_Linux_64bit.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz && \
    rpm -Uvh /maya/Maya*.rpm && \
    rm -r /maya

# Make mayapy the default Python
RUN echo alias hpython="\"/usr/autodesk/maya/bin/mayapy\"" >> ~/.bashrc && \
    echo alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Setup environment
ENV MAYA_LOCATION=/usr/autodesk/maya/
ENV PATH=$MAYA_LOCATION/bin:$PATH

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    mayapy get-pip.py

RUN mayapy -m pip install \
 nose \
 mock

# Cleanup
WORKDIR /root
