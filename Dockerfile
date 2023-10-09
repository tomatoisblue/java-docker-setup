FROM amazoncorretto:17

# タイムアウトする場合はこちらをコメントアウトする
# RUN echo 'timeout=120' >> /etc/yum.conf

# groupadd等を利用するためにshow-utilsをインストール
RUN yum update -y &&\
    yum install shadow-utils -y

ARG GROUPNAME
ARG USERNAME
ARG PASSWORD
ARG GID
ARG UID


# デフォルトユーザを追加
RUN groupadd -g $GID $GROUPNAME &&\
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME &&\
    echo $USERNAME:$PASSWORD | chpasswd &&\
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME/

EXPOSE 8080
