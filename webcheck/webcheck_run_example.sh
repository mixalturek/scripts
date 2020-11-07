#!/bin/bash

URL='https://www.seznam.cz/'

"$(dirname "$0")/webcheck.sh" \
  "$URL" \
  'PEPA ZDEPA' \
  'TOMAS MARNY'

RESULT=$?

if [ $RESULT -eq 0 ]
then
  echo 'Everything should be OK.'
else
  echo '!!! FAILURE !!!'
  url_escaped=${URL//&/&amp;}
  "$(dirname "$0")/notify_error.sh" "$url_escaped"
fi
