# gitbucket.herokuapp.com

This project stores the definition of the official demo version of gitbucket available at : http://gitbucket.herokuapp.com/

All plugins available at http://gitbucket.herokuapp.com/ are plugins coming from the official [gitbucket organization](https://github.com/gitbucket).

You can also have a look at the community site http://gitbucket-community.herokuapp.com/ which holds all known plugins maintained by the gitbucket users & [community](https://github.com/gitbucket-plugins).

----

The rest of this README is for maintainers of this project.

## How to deploy

The herokuapp update itself using the content of the github project.
Thus on push, it will autiomatically redeploy with the new content.

## Update to a new version of gitbucket

- change in `update.sh` the version of gitbucket (use the tag value)
  for example from `GITBUCKET_VERSION=4.4` to `GITBUCKET_VERSION=4.5`
- run `./update.sh`
- commit & push the changes
