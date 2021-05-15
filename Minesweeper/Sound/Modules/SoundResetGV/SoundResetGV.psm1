function SoundResetGV(){
$Json = @"
{    
    "Song":  "Win",
    "Pause":  false,
    "Mute":  false,
    "Path":  "D:\\MineSweeper",
    "MediaEnded":  false,
    "SongChanged":  false,
    "PlayList":  [
                     "Surrounded",
                     "Yankee",
                     "Ultimate"
                 ],
    "Playing":  1,
    "SongCount":  2,
    "UnPaused":  false,
    "PausedSongPath":  "",
    "PausedSongDuration":  [
                               "\"Ticks\":  0,",
                               "\"Days\":  0,",
                               "\"Hours\":  0,",
                               "\"Milliseconds\":  0,",
                               "\"Minutes\":  0,",
                               "\"Seconds\":  0,",
                               "\"TotalDays\":  0,",
                               "\"TotalHours\":  0,",
                               "\"TotalMilliseconds\":  0,",
                               "\"TotalMinutes\":  0,",
                               "\"TotalSeconds\":  0"
                           ],
    "PausedSongName":  "",
    "WinLose":  "",
    "PID":  0,
    "Play":  0,
    "Hold":  0
}
"@
    $basePath = (get-item $psscriptroot).parent.parent.FullName
    $Json | Out-file "$basePath\Config\SoundConfig.txt"
}
Export-ModuleMember -Function SoundResetGV