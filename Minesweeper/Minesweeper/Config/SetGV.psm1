function SetGV($user, $attribute, $value){
    #Get Current File's GV's
    #.'\GetGV.ps1'
    $basePath = (get-item $psscriptroot).parent.FullName
    import-module "$basePath\Config\GetGV.psm1" -Function GetGV
    $hash = GetGV "*" "*" | ConvertFrom-Json

    ForEach($hashette in $hash.GlobalVariables){
        If($hashette.User -eq "$user"){
            $hashette.$attribute = $value
        }else{}
    }

    $object = [PSCustomObject]$hash
    $Json = $object | ConvertTo-Json
    Clear-Content -Path "$basePath\Config\GV.txt"
    $Json | out-file "$basePath\Config\GV.txt"
}
Export-ModuleMember -Function SetGV
#SetGV "Chris" "Rows" "3"