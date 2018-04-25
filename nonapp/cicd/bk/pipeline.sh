#!/usr/bin/env bash
set -eu

nonapp/cicd/bk/generate-pipeline-yml /tmp/monorepo-pipeline.yml
cat /tmp/monorepo-pipeline.yml | buildkite-agent pipeline upload
