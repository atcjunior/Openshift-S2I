
# centos7-java-spring-boot-s2i
FROM centos:centos7

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

ENV OPENJDK_VERSION=1.8

# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="OpenJDK image" \
    io.k8s.display-name="openjdk 1.8" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,java,maven,openjdk,webservice" \
    ## Directory to store s2i scripts
    io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
    io.openshift.s2i.destination="/compile/myapp"

    
## update all
## install openjdk
## clear cache
RUN yum -y update --setopt=tsflags=nodocs && \
    yum install -y java-1.8.0-openjdk-devel --setopt=tsflags=nodocs && \
    yum clean all    
    
# Copy the S2I scripts to /usr/local/s2i
COPY ./resources/s2i/bin/ /usr/local/s2i
# Copy Maven settings.xml /opt
COPY ./resources/maven/settings.xml /opt   
   
    

## Add group 1001
## Add user  1001
## Fix Permissions s2i scripts
## create directory to compile application
## create directory to store maven settings.xml
## create directory to deploy application
RUN groupadd -g 1001 appl && useradd -u 1001 -g 1001 -m appl && \
    chmod +x /usr/local/s2i/* && \
    mkdir -p /compile/myapp && \
    mkdir -p /compile/maven && \
    mv /opt/settings.xml /compile/maven && \
    chown -R 1001:1001 /compile && \
    mkdir  /deployment && \
    chown -R 1001:1001 /deployment && \
    chmod -R ug+rwx /deployment     


USER 1001



EXPOSE 8080

# Show information about running this image
CMD ["/usr/local/s2i/usage"]
