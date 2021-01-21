function GetGV($user, $attribute){
    $basePath = (get-item $psscriptroot).parent.FullName
    $Json = Get-Content "$basePath\Config\GV.txt"
    $PSCustomObj = $Json | ConvertFrom-Json
    
    If($user -eq "*" -and $attribute -eq "*"){
        Return $Json
    }elseif($user -ne "*" -and $attribute -eq "*"){
        $null = $variable = $PSCustomObj.GlobalVariables | where-object { $_.User -eq "$user" }
        Return $variable
    }else{
        $null = $variable = $PSCustomObj.GlobalVariables | where-object { $_.User -like "*$user*" }
        Return $variable.$attribute
    }
}
cls
GetGV "*" "User"
#Returns Value of Key. GetGV "Savina" "Rows"
#Returns full Json. GetGV "*" "*"