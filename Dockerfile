FROM jenkins/jenkins:lts
RUN /usr/local/bin/install-plugins.sh azure-acs:0.2.3 blueocean:1.6.1 credentials-binding:1.16 git:3.9.1 ghprb:1.42.0 kubernetes:1.9.2 pipeline-github-lib:1.0 workflow-aggregator:2.5 workflow-job:2.21 azure-credentials 

ENV JENKINS_USER jenkins
ENV JENKINS_PASS DevOpsOH

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
