# ---- ffprobe -------------------------------------------

## Get info
ffprobe -show_format <file>

# Inspect how many streams/channels (for extracting specific channels later)
ffrpboe -show_streams <file>

## Format ouput
ffprobe -print_format json  <file>


### ---- ffmpeg -------------------------------------------

## Convert format

# Video format
ffmpeg -i input.mp4 output.mkv

# Audio format
ffmpeg -i input.flac output.mp3

## Change Bit-rate

# Reduce file size with H.264 — higher crf = smaller file, lower quality (18-28 is sane range)
ffmpeg -i input.mp4 -vcodec libx264 -crf 23 output.mp4

# Compress for web (H.265 — better compression than H.264)
ffmpeg -i input.mp4 -vcodec libx265 -crf 28 output.mp4

## Video Editing

# Cut video without re-encoding (very fast)
ffmpeg -i input.mp4 -ss 00:01:30 -to 00:02:45 -c copy output.mp4

# Combine a separate audio and video file into one
ffmpeg -i video.mp4 -i audio.mp3 -c:v copy -c:a aac -shortest output.mp4

# Record screen on Linux (X11)
ffmpeg -f x11grab -r 30 -s 1920x1080 -i :0.0 -c:v libx264 recording.mp4

## Extract

# Rip/Extract audio track from a video
ffmpeg -i input.mp4 -vn -acodec copy output.aac

# Extract 1 frame per second as images — useful for ML training datasets or thumbnails
ffmpeg -i input.mp4 -vf fps=1 frames/frame_%04d.png

# Turn a sequence of images into a timelapse video
ffmpeg -framerate 24 -pattern_type glob -i 'frames/*.png' -c:v libx264 timelapse.mp4

## Subtitle

# Burn subtitles permanently into video
ffmpeg -i input.mp4 -vf subtitles=subs.srt output.mp4

# Attach subtitle as a soft track (switchable in player)
ffmpeg -i input.mp4 -i subs.srt -c copy -c:s mov_text output.mp4

## Resize/Scale

# Resize to 1280x720, maintaining aspect ratio
ffmpeg -i input.mp4 -vf scale=1280:720 output.mp4

# Scale to 50% of original size
ffmpeg -i input.mp4 -vf scale=iw/2:ih/2 output.mp4

## Thumbnail

# Grab a single frame at the 5th second mark as thumbnail
ffmpeg -i input.mp4 -ss 00:00:05 -vframes 1 thumbnail.jpg


# ---- Streaming Protocols -------------------------------------------

ffplay -v quiet -y 200 "<the-http-url>"

# RTMP
ffmpeg -v quiet -i "<the-http-url>" -vf "scale=-2:200,drawtext=fontfile='c\:/Windows/Fonts/courbd.ttf':text=RTMP:fontsize=30:x=10:y=20:fontcolor=#000000:box=1:boxborderw=5:boxcolor=#ff888888" -vcodec libx264 -f flv rtmp://localhost:1935/live/rtmpdemo

ffplay -v quiet rtmp://localhost:1935/live/rtmpdemo

# SRT
ffmpeg -v quiet -i rtmp://localhost:1935/live/rtmpdemo -vf "drawtext=fontfile='c\:/Windows/Fonts/courbd.ttf':text=SRT:fontsize=30:x=10:y=60:fontcolor=#000000:box=1:boxborderw=5:boxcolor=#ff888888" -vcodec libx264 -f mpegts srt://localhost:1935?streamid=input/live/srtdemo

ffplay -v quiet srt://localhost:1935?streamid=output/live/srtdemo

# HTTP
ffmpeg -v quiet -i srt://localhost:1935?streamid=output/live/srtdemo -vf "drawtext=fontfile='c\:/Windows/Fonts/courbd.ttf':text=HTTP:fontsize=30:x=10:y=100:fontcolor=#000000:box=1:boxborderw=5:boxcolor=#ff888888" -vcodec libx264 -f dash -method PUT http://localhost/live/httpdemo.mpd

ffplay -v quiet http://localhost/live/httpdemo.mpd
