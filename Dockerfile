FROM kasmweb/core-ubuntu-focal:1.15.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

RUN wget https://builds.parsec.app/package/parsec-linux.deb \
	&& apt-get update \
	&& apt-get install -y ./parsec-linux.deb \
	&& rm parsec-linux.deb

RUN echo "/usr/bin/desktop_ready && /usr/bin/parsecd &" > $STARTUPDIR/custom_startup.sh \
	&& chmod +x $STARTUPDIR/custom_startup.sh

RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN apt-get remove -y xfce4-panel

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000