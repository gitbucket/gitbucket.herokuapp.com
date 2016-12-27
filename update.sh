#!/bin/bash

GITBUCKET_VERSION=4.8

GITBUCKET_GIST_PLUGIN_VERSION=4.4.0

echo downloading...
echo -- gitbucket.war.md5 && wget -q -O gitbucket.war.md5 https://github.com/gitbucket/gitbucket/releases/download/$GITBUCKET_VERSION/gitbucket.war.md5 && echo done.
echo

sig1=0

if [ -f gitbucket.war ];
then
	sig1=`/usr/bin/md5sum -b gitbucket.war | cut -d' ' -f1`
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
    echo -- downloading gitbucket-gist-plugin.jar && wget -q -O plugins/gitbucket-gist-plugin-$GITBUCKET_GIST_PLUGIN_VERSION.jar https://github.com/gitbucket/gitbucket-gist-plugin/releases/download/$GITBUCKET_GIST_PLUGIN_VERSION/gitbucket-gist-plugin_2.11-$GITBUCKET_GIST_PLUGIN_VERSION.jar && echo done.
fi

echo
echo process ended. commit \& push the project to update.
