## notes
- kubeserver and localhost:32000 are a microk8s ubuntu server setup
- you can replace kubeserver:32000 and localhost:32000 docker repository for your own docker hub or private repo

## build
- run build.cmd will build the dev agent, that has c++ and the necessary build tools as well as build the base docker images, and db docker image to manage db changes
- run quickbuild.cmd will build the final dockerimage based off of the previous image, applying any lua scripts, etc.  this build is fast, but will not re-compile and CPP file changes.

## folders
### sql
- this is where custom sql changes are applied
### scripts
- this is where custom scripts overwrite default topaz scripts
### build
- this is where custom cpp files overwrite default topaz cpp files
### dbupdate
- this is a docker build for updating database with custom sql without deleting user data
### devagent
- this is the docker build for a C++ developer container

## important files to modify
- yaml - these files may need some slight tweaking to your liking, game-a and game-b simply demonstrate that you can have multiple instances of the map server, and have some of your zones to one map and some zones to another map.
- editing the zonesettings in mods.sql to your IP address that is publicly accessible to the players that want to play.