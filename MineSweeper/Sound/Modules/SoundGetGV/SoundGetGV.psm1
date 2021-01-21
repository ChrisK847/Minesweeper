function SoundGetGV($attribute,$index){
    $ErrorActionPreference = 'Stop'
    $basePath = (get-item $psscriptroot).parent.parent.FullName
    $Content = Get-Content "$basePath\Config\SoundConfig.txt" -Raw
    if($Content.Length -lt 1){
        import-module "$basePath\Modules\SoundResetGV\SoundResetGV.psm1" -Function SoundResetGV
        SoundResetGV
    }
    $PSCustomObj = $Content | Out-String | ConvertFrom-Json
    #Out-File -FilePath "D:\MineSweeper\Logs\SoundGetGVLogs.txt" -InputObject "attribute=$attribute,pscustomobj=$($PSCustomObj.SoundSettings | Get-Member | Format-Table * | Out-string)"
    $null = $variable = $PSCustomObj
    
    if($attribute -eq "*"){
        Return $Content
    }else{
        if($index -eq $null){
            Return $variable.$attribute
        }else{
            Return $variable.$attribute[$index]
        }
    }
}
Export-ModuleMember -Function SoundGetGV