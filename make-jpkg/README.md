# make-jpkg

Command to create debian package for Oracle JAVA from the tar.gz file to make Oracle JAVA setup non-interactive.

### Usage
Move the local direcory where you have the tar.gz file and run the following : 
```
docker run --rm -it -v ${PWD}:/workdir anasaso/debian-jpkg:latest jdk-*.tar.gz
```
Follow the interactive shell to build the debian package.

For more details : https://wiki.debian.org/JavaPackage
