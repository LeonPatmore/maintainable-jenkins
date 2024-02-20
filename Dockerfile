FROM jenkins/jenkins:2.446
COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

USER root
RUN mkdir -p /app
RUN chown jenkins /app
USER jenkins

COPY plugins.yaml /etc/jenkins/plugins.yaml
RUN mkdir /app/plugins
RUN jenkins-plugin-cli --plugin-file /etc/jenkins/plugins.yaml --plugin-download-directory /app/plugins

RUN mkdir /var/jenkins_home/plugins
RUN cp -r -p /app/plugins/. /var/jenkins_home/plugins/.

COPY --chown=jenkins seedJobs.groovy /app/seedJobs.groovy
COPY --chown=jenkins jenkins-casc.yaml /app/jenkins-casc.yaml
ENV CASC_JENKINS_CONFIG /app/jenkins-casc.yaml
