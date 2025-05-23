# build from ubuntu
FROM ubuntu

# set path for the FOP installation
ENV PATH "$PATH:/usr/local/fop-2.11/fop"

# update lists of packages
RUN apt-get update

# install the latest version of OpenJRE
RUN apt-get install -y default-jre

# install wget
RUN apt-get install -y wget

# get the version 2.11 of FOP
RUN wget https://archive.apache.org/dist/xmlgraphics/fop/binaries/fop-2.11-bin.tar.gz

# unpack FOP into /usr/local
RUN tar -xvzf fop-2.11-bin.tar.gz -C /usr/local

# entrypoint 
ENTRYPOINT ["fop"]

# default command will print the current version of FOP
CMD ["-version"]
