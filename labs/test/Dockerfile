FROM #baseimage

USER code 

COPY install.sh /tmp/install.sh
RUN sudo chmod +x /tmp/install.sh
RUN . /tmp/install.sh

USER 1000
ENV USER=coder
