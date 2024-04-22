
cat data/urls.txt | while read url; do
  echo

  vid_id=${url#*v=}
  echo $vid_id

  if find "data/audio" -type f -name "*${vid_id}*" | grep -q .; then
    ls data/audio/*${vid_id}*
    echo "Match found!"
  else

    # check if the video is accessible.
    yt-dlp --print "%(id)s" $url
    if [ $? -ne 0 ]; then
      echo "Skipping..."
      continue
    fi

    ls data/audio/*${vid_id}*
    echo "No match found."

    yt-dlp --extract-audio $url
    echo `yt-dlp --print "%(id)s:%(upload_date)s" $url` >> data/dates.txt
    mv *.opus data/audio/
  fi

done

sort -u data/dates.txt > tmp
grep "\S" tmp > data/dates.txt
rm tmp
