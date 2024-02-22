# Maintainable Jenkins

## Goals

- Manage plugins with specific versions.
- Configure Jenkins automatically.
- Configure Jenkins jobs automatically.
  - Externalise job config from the docker file to support quick additions of jobs.
- Use multiple docker files to share binary data such as plugins.

## Decisions

### Plugins

Plugins are managed in one file (plugins.yaml) and versions are pinned for clarity and stability.

### Jenkins Version

The Jenkins version is pinned in the Dockerfile.

### Jenkins Configuration

Jenkins is configured on startup using the JCasC plugin. This includes:

- Approved signatures.
- Creating the initial seed job.

#### Seed Job

A single job is configured to be created on startup, the seed job. This job is responsible for taking a remote job DSL file and then setting up the rest of the jobs.

This allows us to add/remove jobs without having to rebuild the docker image.

### Docker Image

The docker image should be as simple as possible. Ideally we should expose docker to the Jenkins container (i.e. by exposing the docker sock file) and run complex tasks inside docker images. This avoids us having to install and manage many apps ourselves (such as Python)!

## Docs

- https://verifa.io/blog/getting-started-with-jenkins-config-as-code/
- https://github.com/jenkinsci/job-dsl-plugin/wiki/JCasC
