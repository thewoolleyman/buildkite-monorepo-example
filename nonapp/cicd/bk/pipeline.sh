#!/usr/bin/env bash
set -eu

# generate the pipeline.yml for the monorepo
pipeline_file=/tmp/monorepo-pipeline.yml
$(dirname "${BASH_SOURCE}")/generate-pipeline-yml ${pipeline_file}

# upload the pipeline.yml, if it was generated (if any apps' builds need to be triggered)
if [[ -e ${pipeline_file} ]]
then
  cat ${pipeline_file} | buildkite-agent pipeline upload
else
  echo "${pipeline_file} was not generated, not triggering any app builds."
fi
