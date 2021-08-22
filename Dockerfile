FROM mottosso/mayabase-centos7

MAINTAINER konstruktion@gmail.com

# Download and unpack distribution first, Docker's caching
# mechanism will ensure that this only happens once.
RUN wget http://trial2.autodesk.com/NetSWDLD/2022/MAYA/8A2BC89C-9B8B-33FC-949F-C7CAE28366A4/ESD/Autodesk_Maya_2022_1_ML_Linux_64bit.tgz -O maya.tgz && \
    mkdir /maya && tar -xvf maya.tgz -C /maya && \
    rm maya.tgz && \
    rpm -Uvh /maya/Packages/Maya*.rpm && \
    rpm -Uvh /maya/Packages/Bifrost*.rpm && \
    rpm -Uvh /maya/Packages/Pymel*.rpm && \
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
