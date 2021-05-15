#Combines Logs from WMP logs and Script logs
cls
Try{$SetGVLogs=Get-Content "D:\MineSweeper\Logs\SoundSetGVLogs.txt"}Catch{}
Try{$WMPLogs=Get-Content "D:\MineSweeper\Logs\WMPSoundLog.txt"}Catch{}
Try{$ScriptLogs=Get-Content "D:\MineSweeper\Logs\ScriptLog.txt"}Catch{}
Try{$GetGVLogs=Get-Content "D:\MineSweeper\Logs\SoundGetGVLogs.txt"}Catch{}
Try{$BlankConfigLogs=Get-Content "D:\MineSweeper\Logs\BlankConfigFile.txt"}Catch{}
Try{$MediaLogs=Get-Content "D:\MineSweeper\Logs\MediaLogs.txt"}Catch{}
Try{$MutexLogs=Get-Content "D:\MineSweeper\Logs\mutex.txt"}Catch{}
$AllLogs=$null
ForEach($logs in $SetGVLogs,$WMPLogs,$ScriptLogs,$GetGVLogs,$BlankConfigLogs,$MediaLogs,$MutexLogs){
    $AllLogs += $logs
}

#$CSV = $AllLogs | ConvertTo-Csv -NoTypeInformation
$AllLogs | Sort-object | Out-File "$PSScriptRoot\AllLogs.txt" -Append