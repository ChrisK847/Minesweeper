function SoundResetGV(){
$Json = @"
{
    "Song":  "Bomb",
    "Pause":  true,
    "Mute":  false,
    "Path":  "D:\\MineSweeper\\Sound",
    "MediaEnded":  false,
    "SongChanged":  false,
    "PlayList":  [
                     "Surrounded",
                     "Yankee",
                     "Ultimate"
                 ],
    "Playing":  2,
    "SongCount":  2,
    "UnPaused":  false,
    "PausedSongPath":  "D:\\MineSweeper\\Sound\\Sounds\\Yankee-Doodle-Dandy.wav",
    "PausedSongDuration":  {
                               "Ticks":  0,
                               "Days":  0,
                               "Hours":  0,
                               "Milliseconds":  0,
                               "Minutes":  0,
                               "Seconds":  0,
                               "TotalDays":  0,
                               "TotalHours":  0,
                               "TotalMilliseconds":  0,
                               "TotalMinutes":  0,
                               "TotalSeconds":  0
                           },
    "PausedSongName": "",
    "WinLose": "",
    "PID": 0,
    "Play": 0,
    "Hold": 0
}

"@
    $basePath = (get-item $psscriptroot).parent.parent.FullName
    $Json | Out-file "$basePath\Config\SoundConfig.txt"
}
Export-ModuleMember -Function SoundResetGV