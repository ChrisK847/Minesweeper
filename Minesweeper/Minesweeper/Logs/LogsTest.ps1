cls

function logs($logs){
    $script:sourceModuleName = "FunctionSourceModule"
    $script:moduleName = "FunctionModuleName"
    write-host 1
}

$logs = {
$(Get-date),$sourceModuleName,$moduleName -join ";;;";
logs $this
#Out-file -FilePath "C:\Users\cjohn\Desktop\LogsText.txt" -Append
}

$sourceModuleName = "SourceModule"
$moduleName = "ModuleName"

icm $logs
sleep -Seconds 2
icm $logs