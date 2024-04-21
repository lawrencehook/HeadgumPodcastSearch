#!/bin/bash

ls -1 data/audio | while read audio_file; do
	echo

	vid_id=${audio_file#*\[}
	vid_id=${vid_id%\]*}
	echo "ID: $vid_id"

  if find "data/vtt" -type f -name "*${vid_id}*" | grep -q .; then
    ls data/vtt/*${vid_id}*
    echo "Match found!"
  else
		echo $audio_file
		whisper "data/audio/${audio_file}" --model tiny -f vtt --language English
		mv *.vtt data/vtt
	fi

done
