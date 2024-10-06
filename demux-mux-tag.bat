@echo off

if not exist "%~dp0eac3to\eac3to.exe" (
	echo eac3to.exe cannot be found in eac3to folder
	pause && exit
)
if not exist "%programfiles%\MKVToolNix\mkvmerge.exe" (
	echo mkvmerge.exe cannot be found in "%programfiles%\MKVToolNix\mkvmerge.exe"
	pause && exit
)

setlocal EnableDelayedExpansion
for %%a in (*.mkv) do (
	if not exist "%%~na - 1*" (
		"%~dp0eac3to\eac3to.exe" "%%a" -demux
		del "%%~na*.txt"
	)
	set /a stream=-1
	set /a demuxed_stream=0
	set /a lang_index=0
	set /p=""%%programfiles%%\MKVToolNix\mkvmerge.exe" -o "output\%%~na-2.mkv" "<nul >%%~na.bat

	for %%b in ("%%~na - *") do (
		@REM echo "%%b:~1"
		set /a stream=!stream!+1
		set /a demuxed_stream=!demuxed_stream!+1
		
		echo !stream!
		for %%c in ("%%~na - !demuxed_stream!*.*") do (
			for /f "tokens=5 delims= " %%d in ('echo %%b') do (
				set stream_type=%%d
				if "!stream_type:~-1!" == "," (
					set stream_type=!stream_type:~0, -1!
				)
				if !stream_type! == h265 (
					for /f "tokens=2 delims='" %%e in ('echo %%b') do (
						for /f "tokens=2 delims=-" %%f in ('echo %%e') do (
							set title=%%f
							set title=!title:~1!
						)
						set episode_name=%%e
						set /p="--language !lang_index!:und --track-name "!stream!:!episode_name!" "<nul >>%%~na.bat
					)
					for /f "tokens=6 delims= " %%e in ('echo %%b') do (
						if "%%e" == "720p," (
							set "dimensions=1280x720"
						)
						set /p="--display-dimensions 0:!dimensions! "<nul >>%%~na.bat
					)
				)
				if !stream_type! == VORBIS (
					for /f "tokens=2 delims='" %%e in ('echo %%b') do (
						for /f "tokens=1 delims= " %%f in ('echo %%e') do (
							set lang=%%f
						)
					)
					for /f "tokens=7 delims= " %%e in ('echo %%b') do (
						set channels=%%e
					)
					if !lang! == English (
						set lang_short=en
					)
					if !lang! == Japanese (
						set lang_short=ja
					)
					set /p="--language !stream!:!lang_short! --track-name "!stream!:!lang! !channels! !stream_type!" "<nul >>%%~na.bat
				)
				if !stream_type! == Subtitle (
					for /f "tokens=7 delims= " %%e in ('echo %%b') do (
						for /f "tokens=1 delims=," %%f in ('echo %%e') do (
							if %%f == English (
								set lang_tag=en
							)
							if %%f == Japanese (
								set lang_tag=ja
							)
						)
					)
					for /f "tokens=2 delims='" %%e in ('echo %%b') do (
						set "sub_descr=%%e"
						for /f "tokens=1,2 delims= " %%f in ('echo %%e') do (
							if %%g == Subtitles (
								if %%f == English (
									set lang_tag=en
								)
							)
						)
					)
					set /p="--sub-charset !stream!:UTF-8 --language !stream!:!lang_tag! --track-name "!stream!:!sub_descr!" "<nul >>%%~na.bat
				)
			)
		)
	)

	set /p="%%a --title "!title!" --track-order "<nul >>%%~na.bat
	for /l %%i in (0,1,!stream!) do (
		if %%i lss !stream! (
			set /p="0:%%i,"<nul >>%%~na.bat
		) else (
			set /p="0:%%i"<nul >>%%~na.bat
		)
	)
)
endlocal
mkdir output
copy %0 output
if not exist output\eac3to (
	xcopy eac3to output\eac3to\
)
pause
goto :eof
for %%i in (*.mkv) do (
	"%programfiles%\MKVToolNix\mkvmerge.exe" -o "%%~ni-2.mkv" --language 0:und --track-name ^"0:!episode_name!^" --display-dimensions 0:!dimensions! --language 1:en --track-name ^"1:English 2.0 !audio_type!^" --language 2:ja --track-name ^"2:Japanese 2.0 !audio_type!^" --language 3:ja --track-name ^"3:Japanese Commentary 2.0 !audio_type!^" --sub-charset 4:UTF-8 --language 4:en --track-name ^"4:English Lyrics/Signs^" --default-track-flag 4:no --sub-charset 5:UTF-8 --language 5:en --track-name ^"5:English Subtitles^" --default-track-flag 5:yes --sub-charset 6:UTF-8 --language 6:ja --track-name ^"6:Japanese Commentary Subtitles^" Sword.Art.Online.S01E01.BluRay.720p.Dual.Audio.Lucifer22.mkv --title ^"The World of Swords^" --track-order 0:0,0:1,0:2,0:3,0:5,0:4,0:6
)

goto :eof
for %%i in (*.mkv) do (
	"%programfiles%\MKVToolNix\mkvmerge.exe" -o "%%~ni-2.mkv" --language 0:und --track-name ^"0:Episode 1 - The World of Swords^" --display-dimensions 0:1280x720 --language 1:en --track-name ^"1:English 2.0 AC3^" --language 2:ja --track-name ^"2:Japanese 2.0 AAC^" --language 3:ja --track-name ^"3:Japanese Commentary 2.0 AAC^" --sub-charset 4:UTF-8 --language 4:en --track-name ^"4:English Lyrics/Signs^" --sub-charset 5:UTF-8 --language 5:ja --track-name ^"5:English Subtitles^" --sub-charset 6:UTF-8 --language 6:en --track-name ^"6:Japanese Commentary Subtitles^" ^"^(^" ^"F:\video\Anime\Sword.Art.Online.S1+S2.BluRay.720p.Dual.Audio.Lucifer22\Sword.Art.Online.S01E01.BluRay.720p.Dual.Audio.Lucifer22.mkv^" ^"^)^" --title ^"The World of Swords^" --track-order 0:0,0:1,0:2,0:3,0:4,0:5,0:6
)