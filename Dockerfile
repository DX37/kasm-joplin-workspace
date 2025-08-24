FROM kasmweb/core-ubuntu-noble:develop
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Update the desktop environment to be optimized for a single application
RUN cp $HOME/.config/xfce4/xfconf/single-application-xfce-perchannel-xml/* $HOME/.config/xfce4/xfconf/xfce-perchannel-xml/
RUN cp /usr/share/backgrounds/bg_kasm.png /usr/share/backgrounds/bg_default.png
RUN apt-get remove -y xfce4-panel

RUN RELEASE_VERSION=$(wget -qO - "https://api.github.com/repos/laurent22/joplin/releases/latest" | grep -Po '"tag_name": ?"v\K.*?(?=")') \
    && mkdir -pv /opt/joplin \
    && cd /opt/joplin \
    && wget -O Joplin.AppImage "https://objects.joplinusercontent.com/v${RELEASE_VERSION}/Joplin-${RELEASE_VERSION}.AppImage?source=LinuxInstallScript&type=New" \
    && wget -O joplin.png https://joplinapp.org/images/Icon512.png \
    && chmod +x Joplin.AppImage \
    && ./Joplin.AppImage --appimage-extract \
    && rm Joplin.AppImage \
    && chown -R 1000:1000 /opt/joplin

RUN echo "#!/usr/bin/env bash" > /opt/joplin/squashfs-root/launcher \
    && echo "export APPDIR=/opt/joplin/squashfs-root/" >> /opt/joplin/squashfs-root/launcher \
    && echo "/opt/joplin/squashfs-root/AppRun --no-sandbox "$@"" >> /opt/joplin/squashfs-root/launcher \
    && chmod +x /opt/joplin/squashfs-root/launcher \
    && sed -i 's@^Exec=.*@Exec=/opt/joplin/squashfs-root/launcher@g' /opt/joplin/squashfs-root/joplin.desktop \
    && sed -i 's@^Icon=.*@Icon=/opt/joplin/joplin.png@g' /opt/joplin/squashfs-root/joplin.desktop \
    && cp /opt/joplin/squashfs-root/joplin.desktop $HOME/Desktop \
    && cp /opt/joplin/squashfs-root/joplin.desktop /usr/share/applications \
    && chmod +x $HOME/Desktop/joplin.desktop \
    && chmod +x /usr/share/applications/joplin.desktop

COPY ./custom_startup.sh $STARTUPDIR/custom_startup.sh
RUN chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
