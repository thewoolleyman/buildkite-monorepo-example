#!/usr/bin/env bash
set -eu

$(nonapp/cicd/bk/generate-pipeline-yml) | buildkite-agent pipeline upload
