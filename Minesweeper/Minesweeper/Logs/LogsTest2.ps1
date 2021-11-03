function logs(){
    if($script:sourceModuleName -eq "SMN"){
        $script:sourceModuleName = "FSMN"
    }else{
        $script:sourceModuleName = "SMN"
    }
    if($script:ModuleName -eq "FMN"){
        $script:moduleName = "MN"
    }else{
        $script:ModuleName = "FMN"
    }
    
}

$logs = {
    $(Get-date),$i,$sourceModuleName,$moduleName -join ";;;";
    $script:i++
    logs
}

cls
$sourceModuleName = "SMN"
$moduleName = "MN"
[int]$i=1

while($i -lt 5){
    icm $logs
    sleep -Seconds 2
}