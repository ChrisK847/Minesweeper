Function Sound($soundLoad){
    $ParentPath = (get-item $PSscriptRoot).parent.FullName
    $Path = (get-item $PSScriptRoot).parent.parent.FullName
    $path | Out-file "$Path\SoundModule.txt"
    $PlayWav=New-Object System.Media.SoundPlayer
    switch ($soundLoad){
        Bomb {$file = (get-item "$Path\Sounds\Bomb.wav")}
        Win  {$file = (get-item "$Path\Sounds\winTrumpets.wav")}
        Yankee   {$file = (get-item "$Path\Sounds\Yankee-Doodle-Dandy.wav")}
        Ultimate   {$file = (get-item "$Path\Sounds\Ultimate-Victory.wav")}
        Surrounded {$file = (get-item "$Path\Sounds\Surrounded-by-the-Enemy.wav")}
	#n1  {$file = (get-item "")}
	    default {
            $content = "$(Get-Date);$soundLoad;"
            Add-Content -Value $content -Path "$ParentPath\Logs\SoundSwitch.txt";
        }
    }
    $PlayWav.SoundLocation=$file
    $PlayWav.playsync()
}
Export-ModuleMember -Function Sound