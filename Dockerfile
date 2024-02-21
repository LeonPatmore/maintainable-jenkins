FROM jenkins/jenkins:2.446
COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin/

USER root
RUN mkdir -p /app
RUN chown jenkins /app
USER jenkins

COPY plugins.yaml /app/plugins.yaml
RUN jenkins-plugin-cli --plugin-file /app/plugins.yaml

COPY --chown=jenkins seedJobs.groovy /app/seedJobs.groovy
COPY --chown=jenkins jenkins-casc.yaml /app/jenkins-casc.yaml
ENV CASC_JENKINS_CONFIG /app/jenkins-casc.yaml
