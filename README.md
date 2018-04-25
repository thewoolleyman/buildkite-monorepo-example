# buildkite-monorepo-example

Spike on how to conditionally build different apps in a monorepo filtered by subdirectory changes in commits

## Overview

* `infra/cicd/bk/pipeline.yml` is the main pipeline which conditionally triggers other pipelines
  under `apps/<appname>/cicd/bk/pipeline.yml` based on which of app had its files changed
  as part of a given commit.

# Testing

* To test scripts locally, `export BUILDKITE_COMMIT=$(git rev-parse --verify HEAD)`

## References

* BK Docs on dynamic pipelines:
  https://buildkite.com/docs/pipelines/defining-steps#dynamic-pipelines
* BK docs on how to make one pipeline trigger another:
  https://buildkite.com/docs/pipelines/trigger-step
* BK docs on making a pipeline use a pipeline.yml from a subdirectory:
  https://buildkite.com/docs/pipelines/defining-steps#customizing-the-pipeline-file-path
* Similar example which uses a dynamic pipeline approach:
  https://github.com/zaclang/buildkite-monorepo-example
