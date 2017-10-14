#!/bin/bash

GITBUCKET_VERSION=4.18.0

GITBUCKET_GIST_PLUGIN_VERSION=4.10.0
GITBUCKET_EMOJI_PLUGIN_VERSION=4.5.0

echo downloading...
echo -- gitbucket.war.md5 && wget -q -O gitbucket.war.md5 https://github.com/gitbucket/gitbucket/releases/download/$GITBUCKET_VERSION/gitbucket.war.md5 && echo done.
echo

sig1=0

if [ -f gitbucket.war ];
then
	if [ "$(uname)" == "Darwin" ]; then
		brew install md5sha1sum
		sig1=`md5sum -b gitbucket.war | cut -d' ' -f1`
	else
		sig1=`/usr/bin/md5sum -b gitbucket.war | cut -d' ' -f1`
	fi
fi
sig2=`cut -d' ' -f1 gitbucket.war.md5`

if [ "$sig1" != "$sig2" ]
then
	echo gitbucket signature is wrong, downloading new version
	echo -- gitbucket.war && wget -q -O gitbucket.war https://github.com/gitbucket/gitbucket/releases/download/$GITBUCKET_VERSION/gitbucket.war && echo done.
else
	echo keeping gitbucket.war
fi

echo
echo checking plugins...
mkdir plugins > /dev/null 2>&1

if [ ! -f plugins/gitbucket-gist-plugin-$GITBUCKET_GIST_PLUGIN_VERSION.jar ]
then
    rm plugins/gitbucket-gist-plugin*.jar > /dev/null 2>&1
    echo -- downloading gitbucket-gist-plugin.jar && wget -q -O plugins/gitbucket-gist-plugin-$GITBUCKET_GIST_PLUGIN_VERSION.jar https://github.com/gitbucket/gitbucket-gist-plugin/releases/download/$GITBUCKET_GIST_PLUGIN_VERSION/gitbucket-gist-plugin_2.12-$GITBUCKET_GIST_PLUGIN_VERSION.jar && echo done.
fi

if [ ! -f plugins/gitbucket-emoji-plugin-$GITBUCKET_EMOJI_PLUGIN_VERSION.jar ]
then
    rm plugins/gitbucket-emoji-plugin*.jar > /dev/null 2>&1
    echo -- downloading gitbucket-emoji-plugin.jar && wget -q -O plugins/gitbucket-emoji-plugin-$GITBUCKET_EMOJI_PLUGIN_VERSION.jar https://github.com/gitbucket/gitbucket-emoji-plugin/releases/download/$GITBUCKET_EMOJI_PLUGIN_VERSION/gitbucket-emoji-plugin_2.12-$GITBUCKET_GIST_PLUGIN_VERSION.jar && echo done.
fi

echo
echo process ended. commit \& push the project to update.
