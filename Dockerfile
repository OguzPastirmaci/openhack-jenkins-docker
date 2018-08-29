FROM jenkins/jenkins:lts-alpine
 
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
 
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

RUN /usr/local/bin/install-plugins.sh azure-acs blueocean credentials-binding git ghprb kubernetes pipeline-github-lib workflow-aggregator workflow-job azure-credentials docker-plugin
