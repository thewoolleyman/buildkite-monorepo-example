# buildkite-monorepo-example

Spike on how to conditionally build different apps in a monorepo filtered by subdirectory changes in commits

## Overview

* `nonapp/cicd/bk` contains code to dynamically generate a main `pipeline.yml`,
  which conditionally triggers other pipelines
  under `apps/<appname>/cicd/bk/pipeline.yml` based on which of app had its files changed
  as part of a given commit.
* You must define the "default" branch (usually `master`).  This is a branch which
  will never be force-pushed via rebase or amend.
  * This branch will determine which apps to build by doing a diff against the last PASSED build's SHA.
  * All other branches will determine which apps to build by diffing against the `merge-base` of the HEAD
    of the branch and the default branch.  

## Testing

* To test scripts locally, export required variables.  E.g.:
  `export BUILDKITE_COMMIT=$(git rev-parse --verify HEAD)`

## Buildkite Setup

1. Set up a pipeline for this monorepo which is triggered by github, using the standard BK github setup instructions.
   This is a the main pipeline which will trigger the other apps' pipelines.
   The command to run will be `nonapp/cicd/bk/pipeline.sh`
1. If you only want to build branches which have PRs, then the main monorepo build should have
   its branches limited in the buildkite "Github" config to only the default branch.
1. Set a separate pipeline for each app, **which must be named after the app's dir under `apps`**,
   but do NOT set it to trigger by github.  The "command to run" will be:
   `cat apps/APPNAME/cicd/bk/pipeline.yml | buildkite-agent pipeline upload`
1. The separate apps' pipeline Github config do NOT need to be triggered by github events,
   and don't need any webhooks.

## References

* BK Docs on dynamic pipelines:
  https://buildkite.com/docs/pipelines/defining-steps#dynamic-pipelines
* BK docs on how to make one pipeline trigger another:
  https://buildkite.com/docs/pipelines/trigger-step
* BK docs on making a pipeline use a pipeline.yml from a subdirectory:
  https://buildkite.com/docs/pipelines/defining-steps#customizing-the-pipeline-file-path
* Similar example which uses a dynamic pipeline approach:
  https://github.com/zaclang/buildkite-monorepo-example
* See also BK `#monorepo` channel.
