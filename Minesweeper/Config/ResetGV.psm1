function ResetGV(){
$Json = @"
{
"GlobalVariables": 
    [
        {
             "User":  "Player1",
             "Difficulty":  2,
             "Rows":  6,
             "Mute":  false,
             "LogsOnOff":  'Off'
        }
    ]
}
"@
    $basePath = (get-item $psscriptroot).parent.FullName
    $Json | Out-file "$basePath\Config\GV.txt"
}
    Export-ModuleMember -Function ResetGV