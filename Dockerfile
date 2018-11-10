FROM mikesplain/openvas
MAINTAINER Ashley Abraham "ashley.abraham@jsums.edu"

ENV DEBIAN_FRONTEND noninteractive

# Install metasploit
RUN apt-get -y update \ 
    && apt-get install -y \
        postgresql \
        postgresql-contrib 
    
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall \
    && chmod 755 msfinstall \
    && ./msfinstall 
    
EXPOSE 443 9390
ENV PATH /usr/local/bin:$PATH

# Attach this container to stdin when running, like this:
# docker run --net=host -t -i jsums/msf_openvas
#--net=host allows listening to incoming connections on the host ip

ADD ./init.sh /init.sh
RUN chmod +x /init.sh
ENTRYPOINT ./init.sh
