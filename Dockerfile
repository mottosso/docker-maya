FROM mottosso/mayabase-centos7

MAINTAINER konstruktion@gmail.com

# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
RUN wget https://efulfillment.autodesk.com/NetSWDLD/2024/MAYA/537B71D7-A391-3E25-93C3-9967181B3F34/ESD/Autodesk_Maya_2024_Linux_64bit.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz && \
    rpm -Uvh /maya/Packages/Maya*.rpm && \
    rm -r /maya

# Make mayapy the default Python
RUN echo alias hpython="\"/usr/autodesk/maya/bin/mayapy\"" >> ~/.bashrc && \
    echo alias hpip="\"mayapy -m pip\"" >> ~/.bashrc

# Setup environment
ENV MAYA_LOCATION=/usr/autodesk/maya/
ENV PATH=$MAYA_LOCATION/bin:$PATH

# Avoid warning about this variable not set, the path is its default value
RUN mkdir /var/tmp/runtime-root && \
    chmod 0700 /var/tmp/runtime-root
ENV XDG_RUNTIME_DIR=/var/tmp/runtime-root

# Workaround for "Segmentation fault (core dumped)"
# See https://forums.autodesk.com/t5/maya-general/render-crash-on-linux/m-p/5608552/highlight/true
ENV MAYA_DISABLE_CIP=1

# Cleanup
WORKDIR /root
