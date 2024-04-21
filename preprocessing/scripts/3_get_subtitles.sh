#!/bin/bash

ls -1 data/audio | while read audio_file; do

  filename=${audio_file/opus/vtt}
  if [ -f "data/vtt/${filename}" ]; then
    echo "Match found!"
  else
		echo
		echo $audio_file
		whisper "data/audio/${audio_file}" --model tiny -f vtt --language English
		mv *.vtt data/vtt
	fi

done
