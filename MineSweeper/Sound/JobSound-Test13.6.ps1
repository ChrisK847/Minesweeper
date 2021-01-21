
#ISSUES:
<#
    After several songs, when pausing and unpausing, the music stopped and I couldn't get it started again. See Below SoundConfig; null value, 0 value. Also, I don't think the songs played in the correct order
    via the playlist. It went Surrounded, Ultimate, Yankee..

    {
    "Song":  "Yankee",
    "Pause":  false,
    "Play":  true,
    "First":  false,
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
    "PausedSongPath":  null,
    "PausedSongDuration":  0,
    "PausedSongName":  "Yankee"
}

#>

$function = {
    Function Sound(){
        Import-Module "$using:path\Modules\SoundGetGV\SoundGetGV.psm1" -Function SoundGetGV
        Import-Module "$using:path\Modules\SoundSetGV\SoundSetGV.psm1" -Function SoundSetGV
        $Path=SoundGetGV "Path"
        
        Function Change($pla,$pau,$mut,$fir,$nex,$son){
            Import-Module "$using:path\Modules\SoundGetGV\SoundGetGV.psm1" -Function SoundGetGV
            Import-Module "$using:path\Modules\SoundSetGV\SoundSetGV.psm1" -Function SoundSetGV
            $Path=SoundGetGV "Path"
            $pause = SoundGetGV "Pause"
            $play = SoundGetGV "Play"
            $mute = SoundGetGV "Mute"
            $first = SoundGetGV "First"
            $Path= SoundGetGV "Path"
            #"Line 46, $($player.position.ticks)" | Out-File "D:\MineSweeper\Sound\Config\Songlog.txt" -Append
            if($(SoundGetGV "UnPaused") -eq $false -and $(SoundGetGV "Pause") -eq $false){
                $song = SoundGetGV "PlayList" $(SoundGetGV "Playing")
                SoundSetGV "Song" $song
                if($(SoundGetGV "Playing") -eq $(SoundGetGV "SongCount")){
                    SoundSetGV "Playing" 0
                }else{
                    SoundSetGV "Playing" $($(SoundGetGV "Playing") + 1)
                }
                switch ($song){
                    Bomb {$file = (get-item "$using:path\Sounds\Bomb.wav")}
                    Win  {$file = (get-item "$using:path\Sounds\winTrumpets.wav")}
                    Yankee   {$file = (get-item "$using:path\Sounds\Yankee-Doodle-Dandy.wav")}
                    Ultimate   {$file = (get-item "$using:path\Sounds\Ultimate-Victory.wav")}
                    Surrounded {$file = (get-item "$using:path\Sounds\Surrounded-by-the-Enemy.wav")}
	                #n1  {$file = (get-item "")}
	                default {
                        $content = "Date=$(Get-Date);song=$song"
                        Add-Content -Value $content -Path "$script:ParentPath\Logs\SongSwitch.txt"; ###ADD PARENTPATH VARIABLE USING
                    }
                }
            }else{
                SoundSetGV "UnPaused" $false
            }

            if($pause -eq $true){
                $Player.Pause()
                #SoundSetGV "PausedSongName" $song
                SoundSetGV "PausedSongDuration" $($Player.Position.Ticks)
                #SoundSetGV "PausedSongPath" $($file.FullName)
            }elseif($pause -eq $false){
                if($(SoundGetGV "MediaEnded") -eq $true -or $(SoundGetGV "SongChanged" -eq $true)){
                        $Player.Open($($file.FullName))
                        SoundSetGV "MediaEnded" $false
                        SoundSetGV "SongChanged" $false
                        $Player.Play()
                        SoundSetGV "PausedSongName" $song
                        SoundSetGV "PausedSongPath" $($file.FullName)
                    if($mute -eq $true){
                        $Player.IsMuted=$true
                    }elseif($mute -eq $false){
                        $Player.IsMuted=$false
                    }else{}

                }else{
                    $Player.Open($(SoundGetGV "PausedSongPath"))
                    $player.Position = $(SoundGetGV "PausedSongDuration")
                    SoundSetGV "MediaEnded" $false
                    SoundSetGV "SongChanged" $false
                    $Player.Play()
                    #"Line 68, pausedSongPath=$(SoundGetGV "PausedSongPath"), PausedSongDuration=$(SoundGetGV "PausedSongDuration")" | Out-File "D:\MineSweeper\Sound\Config\Songlog.txt" -Append
                    if($mute -eq $true){
                        $Player.IsMuted=$true
                    }elseif($mute -eq $false){
                        $Player.IsMuted=$false
                    }else{}
                }   
            }
            Return {[ref]$player; [ref]$mediaEnded}
        } #End Function Change

        $i = $true
        $play = SoundGetGV "Play"
        $pause = SoundGetGV "Pause"
        $mute = SoundGetGV "Mute"
        $first = SoundGetGV "First"
        $song = SoundGetGV "Song"
        $mediaEnded = SoundGetGV "MediaEnded"
        $songChanged = SoundGetGV "SongChanged"
        SoundSetGV "PlayList" $("Yankee","Ultimate","Surrounded" | Sort-Object {Get-Random})
        SoundSetGV "SongCount" $($(SoundGetGV "PlayList").Count - 1)
        SoundSetGV "Playing" 0
        SoundSetGV "UnPaused" $false
        SoundSetGV "PausedSongPath" ""
        SoundSetGV "PausedSongDuration" $(
                               '"Ticks":  0,',
                               '"Days":  0,',
                               '"Hours":  0,',
                               '"Milliseconds":  0,',
                               '"Minutes":  0,',
                               '"Seconds":  0,',
                               '"TotalDays":  0,',
                               '"TotalHours":  0,',
                               '"TotalMilliseconds":  0,',
                               '"TotalMinutes":  0,',
                               '"TotalSeconds":  0'
        )
        SoundSetGV "PausedSongName" ""
    :doloop    do{
                    if($($play -ne $(SoundGetGV "Play")) -or $($pause -ne $(SoundGetGV "Pause")) -or $($First -eq $true) -or $(SoundGetGV "MediaEnded") -eq $true -or $($mute -ne $(SoundGetGV "Mute")) -or $song -ne $(SoundGetGV "Song")){
                        if($play -ne $(SoundGetGV "Play")){$pla=1}
                        if($pause -ne $(SoundGetGV "Pause")){$pau=1; if($(SoundGetGV "Pause") -eq $false){SoundSetGV "UnPaused" $true}}
                        if($mute -ne $(SoundGetGV "Mute")){$mut=1}
                        if($first -ne $(SoundGetGV "First")){$fir=1}
                        if($song -ne $(SoundGetGV "Song")){SoundSetGV "SongChanged" $true}
                        Change $pla $pau $mut $fir $nex $son
                        $first = SoundSetGV "First" $false
                    }else{}
                    $play = SoundGetGV "Play"
                    $pause = SoundGetGV "Pause"
                    $mute = SoundGetGV "Mute"
                    $first = SoundGetGV "First"
                    $mediaEnded = SoundGetGV "MediaEnded"
                    $song = SoundGetGV "Song"
                    Start-Sleep -Milliseconds 1000
                    if($player.Position.Ticks -eq $player.NaturalDuration.TimeSpan.Ticks){$mediaEnded=$true;SoundSetGV "MediaEnded" $true}
                }While($i -eq $true)
    }
    Import-Module "$using:path\Modules\SoundGetGV\SoundGetGV.psm1" -Function SoundGetGV
    Import-Module "$using:path\Modules\SoundSetGV\SoundSetGV.psm1" -Function SoundSetGV
    $path=SoundGetGV "Path"
    Add-Type -AssemblyName PresentationCore 
    $Player = [System.Windows.Media.MediaPlayer]::new()
    SoundSetGV "Path" $path
    SoundSetGV "Play" $true #"true"
    SoundSetGV "Pause" $false #"false"
    SoundSetGV "Mute" $false #"false"
    SoundSetGV "First" $true #"true"
    SoundSetGV "MediaEnded" $true
    $global:play=SoundGetGV "Play"
    $global:pause=SoundGetGV "Pause"
    $global:mute=SoundGetGV "Mute"
    $global:first=SoundGetGV "First"
    $global:MediaEnded=SoundGetGV "MediaEnded"
    Sound
}
cls
$music=1
Try{Stop-Job *}Catch{}
Try{Remove-Job -State Completed}Catch{}
$path=(get-item $PSScriptRoot).FullName
Try{Remove-Module SoundGetGV -ErrorAction Stop}Catch{}
Try{Remove-Module SoundSetGV -ErrorAction Stop}Catch{}
Try{Remove-Module SoundResetGV -ErrorAction Stop}Catch{}
Import-Module "$path\Modules\SoundGetGV\SoundGetGV.psm1" -Function SoundGetGV -Scope Global
Import-Module "$path\Modules\SoundSetGV\SoundSetGV.psm1" -Function SoundSetGV
SoundSetGV "Path" $path
$null = $musicJob = Start-Job -Name SongLoop -ScriptBlock $function -ArgumentList $path,$music
$null = Register-ObjectEvent -InputObject $musicJob -EventName StateChanged -Action {$music = 0;write-host $music}