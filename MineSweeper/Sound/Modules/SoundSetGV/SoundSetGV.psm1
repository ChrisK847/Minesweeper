function SoundSetGV($attribute, $value, $line){
    $ErrorActionPreference = 'Stop'
    $basePath = (get-item $psscriptroot).parent.parent.FullName
    Out-File -FilePath "$basePath\Config\SongLog.txt" -InputObject $("$(Get-Date), Line=$line, $attribute, $value") -append
    Try{Remove-Module SoundGetGV}catch{}
    import-module "$basePath\Modules\SoundGetGV\SoundGetGV.psm1" -Function SoundGetGV -Scope global
    import-module "$basePath\Modules\SoundResetGV\SoundResetGV.psm1" -Function SoundResetGV -Scope global
    Try{$hash = SoundGetGV "*" | ConvertFrom-Json}catch{}
    #Out-File -FilePath "$basePath\SoundLogs.txt" -InputObject $hash -append
    Try{$hash.$attribute = $value}catch{}
    #Out-File -FilePath "$basePath\SoundLogs.txt" -InputObject $hash -append
    $object = [PSCustomObject]$hash
    $Json = $object | ConvertTo-Json
    #Clear-Content -Path "$basePath\Sound\SoundConfig.txt"
    $Json | out-file "$basePath\Config\SoundConfig.txt"
}
Export-ModuleMember -Function SoundSetGV