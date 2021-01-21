$raw = @'
HoldNextSongFlag, PauseFlag, PauseMusic
HoldNextSongFlag, PauseFlag, MuteFlag, PauseMusic, MuteMusic
HoldNextSongFlag, PauseFlag, PauseMusic, UnMuteFlag, UnMuteMusic
PauseFlag, PauseMusic
PauseFlag, PauseMusic, MuteFlag, MuteMusic
PauseFlag, PauseMusic, UnMuteFlag, UnMuteMusic
EndWinLoseSongFlag, UnPause, PlayPausedMusic
EndWinLoseSongFlag, UnPauseFlag, MuteFlag, PlayPausedMusic, MuteMusic
EndWinLoseSongFlag, UnPauseFlag, UnMuteFlag, UnMuteMusic, PlayPausedMusic
HoldNextSongFlag, WinLoseFlag, PlayWinLoseSong
HoldNextSongFlag, WinLoseFlag, PlayWinLoseSong, MuteFlag, MuteMusic
HoldNextSongFlag, WinLoseFlag, PlayWinLoseSong, UnMuteFlag, UnMuteMusic
WinLoseFlag, PlayWinLoseSong
WinLoseFlag, PlayWinLoseSong, MuteFlag, MuteMusic
WinLoseFlag, PlayWinLoseSong, UnMuteFlag, UnMuteMusic
MediaEndedFlag, PlayNextSong
MediaEndedFlag, PlayNextSong, MuteFlag, MuteMusic
MediaEndedFlag, PlayNextSong, UnMuteFlag, UnMuteMusic
Keep Looping, MediaEndedFlag, PlayNextSong
MuteFlag, MuteMusic
UnMuteFlag, UnMuteMusic
'@

$compare = @'
EndWinLoseSongFlag
HoldNextSongFlag
Keep Looping
MediaEndedFlag
MuteFlag
MuteMusic
PauseFlag
PauseMusic
PlayNextSong
PlayPausedMusic
PlayWinLoseSong
UnMuteFlag
UnMuteMusic
UnPauseFlag
WinLoseFlag
'@

cls
$i = 0
$lines = $raw.Split([Environment]::NewLine)
$listItems = $compare.Split([Environment]::NewLine)

$sListItems = $listItems | %{$_.Trim()}
$slines = $lines | %{$_.Split(",").Trim()}
