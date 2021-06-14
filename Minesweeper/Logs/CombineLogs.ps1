#Combines Logs from WMP logs and Script logs
cls
Try{$SetGVLogs=Get-Content "$PSScriptRoot\SoundSetGVLogs.txt"}Catch{}
Try{$WMPLogs=Get-Content "$PSScriptRoot\WMPSoundLog.txt"}Catch{}
Try{$ScriptLogs=Get-Content "$PSScriptRoot\ScriptLog.txt"}Catch{}
Try{$GetGVLogs=Get-Content "$PSScriptRoot\SoundGetGVLogs.txt"}Catch{}
Try{$BlankConfigLogs=Get-Content "$PSScriptRoot\BlankConfigFile.txt"}Catch{}
Try{$MediaLogs=Get-Content "$PSScriptRoot\MediaLogs.txt"}Catch{}
Try{$MutexLogs=Get-Content "$PSScriptRoot\mutex.txt"}Catch{}
$AllLogs=$null
ForEach($logs in $SetGVLogs,$WMPLogs,$ScriptLogs,$GetGVLogs,$BlankConfigLogs,$MediaLogs,$MutexLogs){
    $AllLogs += $logs
}

#$CSV = $AllLogs | ConvertTo-Csv -NoTypeInformation
$AllLogs | Sort-object | Out-File "$PSScriptRoot\AllLogs.txt" -Append