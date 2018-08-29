FROM jenkins/jenkins:lts

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/default-user.groovy

RUN /usr/local/bin/install-plugins.sh azure-acs blueocean credentials-binding git ghprb kubernetes pipeline-github-lib workflow-aggregator workflow-job azure-credentials docker-plugin