FROM codercom/code-server:4.19.0-focal

USER root

# Grant sudo privileges to the coder user
RUN usermod -aG sudo coder

# Revert to the coder user
USER coder

RUN sudo apt-get update -y && sudo apt-get dist-upgrade -y 

# Create the necessary directory
RUN sudo mkdir -p /home/coder/.local/share/code-server
RUN sudo mkdir -p /home/coder/project

# Grant coder ownershitp to project and code-server directories
RUN sudo chown -R coder:coder /home/coder/.local/share/code-server 
RUN sudo chown -R coder:coder /home/coder/project

# Copy the .vscode directory to the appropriate location
COPY .vscode /home/coder/.local/share/code-server/User/.vscode
COPY .vscode /home/coder/project/


# Set working directory
WORKDIR /home/coder/project/

ENTRYPOINT ["/lib/systemd/systemd"]