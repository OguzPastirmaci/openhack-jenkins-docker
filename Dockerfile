FROM jenkins/jenkins:lts

RUN /usr/local/bin/install-plugins.sh azure-acs blueocean credentials-binding git ghprb kubernetes pipeline-github-lib workflow-aggregator workflow-job azure-credentials docker-plugin