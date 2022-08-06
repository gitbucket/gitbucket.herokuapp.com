#!/bin/bash

GITBUCKET_VERSION=4.37.2

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
echo process ended. commit \& push the project to update.
