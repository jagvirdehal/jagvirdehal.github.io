#!/bin/bash

# {   printf '{ "text":"'
#     cat $1
#     printf '"}'
# }

# {   printf '{ "text":"'
#     cat $1
#     printf '"}'
# } | curl -L \
#   -X POST \
#   -H "Accept: application/vnd.github+json" \
#   -H "Authorization: Bearer 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" \
#   -H "X-GitHub-Api-Version: 2022-11-28" \
#   https://api.github.com/markdown/raw \
#   --data-binary @-


cat $1 | curl -L \
  -X POST \
  -H "Content-Type: text/plain" \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer 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" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/markdown/raw \
  --data-binary @- | \
  sed '/^<h2>.*/i </div>\n<div id="group" class="h2-group">' | \
  sed '0,/div/{/div/d;}' | \
  sed '$a</div>' | \
  sed '1i<div id="head">' | \
  sed '/^<p>.*/a </div>\n<div id="body">' | \
  sed '$a</div>' | \
  sed '1i<head><link rel="stylesheet" href="style.css"/></head>' | \
  sed -z 's/id="group"/id="group1"/1' | \
  sed -z 's/id="group"/id="group2"/1' | \
  sed -z 's/id="group"/id="group3"/1' | \
  sed -z 's/id="group"/id="group4"/1' | \
  sed -z 's/id="group"/id="group5"/1'
