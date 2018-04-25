#!/usr/bin/env bash
set -eu

pipeline_file=/tmp/monorepo-pipeline.yml
$(dirname "${BASH_SOURCE}")/generate-pipeline-yml ${pipeline_file}

if [[ -e ${pipeline_file} ]]
then
  cat ${pipeline_file} | buildkite-agent pipeline upload
else
  echo "${pipeline_file} was not generated, not triggering any app builds."
fi

