# centreon-docker

Docker file and workarounds to have Centreon 22.10 running in a Docker container based on Debian Bully.

Install instructions :
- clone reposiroty
- docker build -t centreon:latest .
- create a container from built image and expose network port 80
- bash into started container
- follow mysql_secure_installation section and following instructions from below documentation to get started

Build intructions based on :
https://docs.centreon.com/fr/docs/installation/installation-of-a-central-server/using-packages/

Workarounds: 
- start.sh file to start important mandatory services at container startup
- service files : converted and adapted from systemd service files
