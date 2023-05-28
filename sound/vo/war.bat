for %%a in ("*.wav") do ffmpeg -i "%%a" -codec:a libmp3lame -qscale:a 2 "%%~na.mp3"
