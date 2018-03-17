
# centos7-nodejs6
FROM centos:centos7

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

ENV NODEJS=6
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8   


# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="Nodejs Application" \
    io.k8s.display-name="Nodejs6" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,nodejs" \
    ## Directory to store s2i scripts
    io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
    io.openshift.s2i.destination="/compile/myapp"
    

## update all
## install epel-release
## install nodejs and git
RUN yum -y update --setopt=tsflags=nodocs && \
    yum -y install epel-release && \
    curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -  && \
    yum install -y --setopt=tsflags=nodocs nodejs git && \
    yum clean all



# Copy the S2I scripts to /usr/local/s2i
COPY ./resources/s2i/bin/ /usr/local/s2i



## Add group 1001
## Add user  1001
## Fix Permissions
## create diretory to compile application
RUN groupadd -g 1001 appl && useradd -u 1001 -g 1001 -m appl && \
    chmod +x /usr/local/s2i/* && \
    mkdir -p /compile/myapp && \
    chown -R 1001:1001 /compile && \
    mkdir  /deployment && \
    chown -R 1001:1001 /deployment && \
    chmod -R ug+rwx /deployment 


USER 1001

EXPOSE 8080

# Show information about running this image
CMD ["/usr/local/s2i/usage"]
