FROM linuxserver/rutorrent

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="alex-phillips"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	git && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	python2 && \
 echo "**** install pyrocore ****" && \
 mkdir -p /root/bin && \
 git clone "https://github.com/pyroscope/pyrocore.git" /pyroscope && \
 /pyroscope/update-to-head.sh &&  \
 mv ~/bin/* /usr/bin/ &&  \
 echo "**** symlink pyroscope config dir ****" &&  \
 rm -rf /root/.pyroscope &&  \
 ln -s /config/pyroscope /root/.pyroscope &&  \
 chown -R abc:abc /pyroscope &&  \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/etc/nginx/conf.d/default.conf \
	/tmp/*
