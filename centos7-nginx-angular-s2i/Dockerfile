
# centos7-nginx-angular
FROM centos:centos7

LABEL maintainer="Antonio Tolentino - atcjunior@gmail.com"

ENV NGINX_VERSION=1.12.1-1
ENV NODEJS=6
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8   

# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="Nginx Webserver" \
    io.k8s.display-name="Nginx 1.12.1-1" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,webserver,html,nginx,nodejs,angular" \
    ## Directory to store s2i scripts
    io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
    io.openshift.s2i.destination="/compile/myapp"
    

    
# Add nginx repository to yum
COPY ./resources/nginx.repo /etc/yum.repos.d/    

## update all
## install epel-release
## install nginx
## install nodejs and git
## install angular/cli
## Remove directive user from nginx.conf
RUN yum -y clean all && \
    yum -y update --setopt=tsflags=nodocs && \
    yum -y install epel-release && \
    curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -  && \
    yum install -y --setopt=tsflags=nodocs nginx nodejs git && \
    npm install -g @angular/cli && \    
    yum clean all && \
    sed -i 's/user  nginx;//' /etc/nginx/nginx.conf



# Add Custom nginx.conf
#COPY ./nginx.conf /etc/nginx
COPY ./resources/default.conf /etc/nginx/conf.d/

# Copy the S2I scripts to /usr/local/s2i
COPY ./resources/s2i/bin/ /usr/local/s2i



## Add group 1001
## Add user  1001
## Fix Permissions
## create diretory to compile application
RUN groupadd -g 1001 appl && useradd -u 1001 -g 1001 -m appl && \
    chmod +x /usr/local/s2i/assemble && \
    chmod +x /usr/local/s2i/run && \
    chmod +x /usr/local/s2i/save-artifacts && \
    chmod +x /usr/local/s2i/usage && \
    chown -R 1001:1001 /usr/share/nginx && \
    chmod -R ugo+rwx /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chmod ugo+rwx /var/run/nginx.pid && \
    chmod -R ugo+rwx /var/cache/nginx/ && \
    mkdir -p /compile/myapp && \
    chown -R 1001:1001 /compile


USER 1001



EXPOSE 8080

# Show information about running this image
CMD ["/usr/local/s2i/usage"]
