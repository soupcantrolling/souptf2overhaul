@echo off
setlocal EnableDelayedExpansion

for /r %%f in (*.mp4) do (

    set "baseName=%%~nf"
    set "ext=%%~xf"

    if not "!baseName:COMPRESSED=!" == "!baseName!" (
        echo Skipping "%%f" because it is already compressed.
    ) else (

        set "fileDir=%%~dpf"
        set "compressedFileName=!baseName!_COMPRESSED!ext!"
        set "compressedFilePath=!fileDir!!compressedFileName!"

        echo Compressing "%%f"...

        ffmpeg -hide_banner -loglevel panic -i "%%f" -c:v libx264 -preset slow -crf 23 -c:a copy "!compressedFilePath!"

        if exist "!compressedFilePath!" (
            del "%%f"
        )

        echo Compression of "%%f" complete.
    )
)

echo Compression complete!
exit >nul