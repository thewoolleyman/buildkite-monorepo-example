#!/usr/bin/env bash
set -eu

$(infra/cicd/bk/generate-pipeline-yml) | buildkite-agent pipeline upload
