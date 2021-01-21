Function Sound($soundLoad){
    $music=1
    Try{Remove-Job -State Completed}Catch{}
    $loop = {
        Add-Type -AssemblyName PresentationCore 
        $Player = [System.Windows.Media.MediaPlayer]::new()
        $file = (get-item "D:\MineSweeper\Sound\Bomb.wav")
        $player.Open($file.FullName)
        $player.Play()
        Do{
              $s = $Player.Position.Milliseconds;
              Start-Sleep -Milliseconds 200;
        }While($Player.Position.Milliseconds -ne $s);
    }
    $null = $musicJob = Start-Job -Name SongLoop -ScriptBlock $loop
    $null = Register-ObjectEvent -InputObject $musicJob -EventName StateChanged -Action {$music = 0}
}
Export-ModuleMember -Function Sound