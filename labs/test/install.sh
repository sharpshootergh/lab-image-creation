#!/bin/sh


 # install KUBECLI

if ! command -v kubecli &> /dev/null; then 
 
 echo "
                  installing KUBECLI.....

      "
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
   echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
   sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl





 echo "

                  installing KUBECLI.....
                  
      "

fi      
rm -rf /home/coder/project/*