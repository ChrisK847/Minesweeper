function GetGV($user, $attribute){
    $basePath = (get-item $psscriptroot).parent.FullName
    #Out-file -FilePath "$basePath\Logs\GetGVLogs.txt" -InputObject "$user, $attribute`n$($user -eq "*"), $($attribute -eq "*")`n$($user -like "*"), $($attribute -like "*")`n$($user -ne "*"), $($attribute -ne "*")`n$($user -notlike "*"), $($attribute -notlike "*")"
    $Json = Get-Content "$basePath\Config\GV.txt"
    $PSCustomObj = $Json | ConvertFrom-Json
    If($user -eq "*" -and $attribute -ne "*"){
        $null = $variable = $PSCustomObj.GlobalVariables | where-object { $_.User -like "*" }
        Return $variable.$attribute    
    }elseif($user -eq "*" -and $attribute -eq "*"){
        Return $Json
    }elseif($user -ne "*" -and $attribute -eq "*"){
        $null = $variable = $PSCustomObj.GlobalVariables | where-object { $_.User -eq "$user" }
        Return $variable
    }elseif($user -ne "*" -and $attribute -ne "*"){
        $null = $variable = $PSCustomObj.GlobalVariables | where-object { $_.User -eq "$user" }
        Return $variable.$attribute
    }else{
	Return "Please specify Name and Attribute correctly."
    }
}
Export-ModuleMember -Function GetGV
#Returns Value of Key. GetGV "Savina" "Rows"
#Returns full Json. GetGV "*" "*"