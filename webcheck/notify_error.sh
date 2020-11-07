#!/bin/bash

URL_ESCAPED="$1"

zenity \
  --error \
  --title="Webcheck failure!" \
  --text="Please re-check manually...\n<a href=\"$URL_ESCAPED\">$URL_ESCAPED</a>" \
  --ok-label="OK" \
  --no-wrap
