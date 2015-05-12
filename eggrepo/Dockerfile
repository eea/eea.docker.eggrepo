FROM eeacms/cluereleasemanager

MAINTAINER "Vitalie Maldur" <vitalie.maldur@eaudeweb.ro>

## user info
ENV EGG_USER egguser
ENV EGG_PASS eggpass
ENV EGG_USER_EMAIL egguser@localhost

## adding user to egg server as manager
RUN cluerelmgr-admin updateuser $EGG_USER $EGG_PASS $EGG_USER_EMAIL manager

## allowing anonymous access
RUN cluerelmgr-admin updateusersgroups anonymous common
RUN cluerelmgr-admin updategroup common manager
