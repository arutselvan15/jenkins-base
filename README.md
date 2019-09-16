# jenkins-base

Jenkins base with docker

Jenkins alpine with docker container.  Jenkins master is configured to use local system docker socker to run the builds jobs.

# Help

You need to change the /var/run/docker.socket permission to 0777 to get it working in jenksin container.

# Reference

    https://github.com/jenkinsci/docker/blob/master/README.md

    https://medium.com/@gustavo.guss/quick-tutorial-of-jenkins-b99d5f5889f2

    https://medium.com/@manav503/how-to-build-docker-images-inside-a-jenkins-container-d59944102f30

