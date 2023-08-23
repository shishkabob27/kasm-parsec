FROM kasmweb/core-ubuntu-focal:1.12.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########



RUN wget https://builds.parsec.app/package/parsec-linux.deb \
    && apt-get update \
#    && apt-get install libssl-dev \
    && apt-get install ./parsec-linux.deb \
    && cp /usr/share/applications/parsecd.desktop $HOME/Desktop/ \
    && chmod +x $HOME/Desktop/parsecd.desktop \
    && chown 1000:1000 $HOME/Desktop/parsecd.desktop 
#    && /usr/share/applications/parsecd.desktop

#RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN cp /usr/share/extra/backgrounds/bg_kasm.png /usr/share/extra/backgrounds/bg_default.png
#RUN apt-get remove -y xfce4-panel

run /usr/bin/parsecd

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000