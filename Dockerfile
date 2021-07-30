FROM ubuntu:trusty

# ubuntu:latest does not have sudo
# fetch it and install it
RUN apt-get update && apt-get install -y sudo

# Create new user `dockerberton` and disable 
# password and gecos for later
# --gecos explained well here:
# https://askubuntu.com/a/1195288/635348
RUN adduser --disabled-password \
--gecos '' dockerberton

#  Add new user dockerberton to sudo group
RUN adduser dockerberton sudo

# Ensure sudo group users are not 
# asked for a password when using 
# sudo command by ammending sudoers file
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> \
/etc/sudoers

# now we can set USER to the 
# user we just created
USER dockerberton

# we can now run sudo commands 
# as non-root user `docker` without
# password prompt
RUN sudo apt-get update 

# Switch shell from default /bin/sh to /bin/bash
SHELL ["/bin/bash", "-c"]

# Install git
RUN sudo apt-get install -y git

# Change workingdir to /home/dockerberton
WORKDIR /home/dockerberton

# Install betty
RUN git clone https://github.com/holbertonschool/Betty.git
WORKDIR /home/dockerberton/Betty
RUN sudo ./install.sh

WORKDIR /home/dockerberton

# Install gcc
RUN sudo apt-get install -y gcc
# Install valgrind
RUN sudo apt-get install -y valgrind
# Install GDB
RUN sudo apt-get install gdb

COPY .. .

# Echo a message when container starts
CMD ["bash"]

