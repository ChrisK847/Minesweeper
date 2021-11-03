function SoundSetGV($attribute, $value, $line, $lineName, $logsPath){
    $ErrorActionPreference = 'Stop'
    $logsOnOff = 'Off' #On or Off
    function LineNumber {
        $MyInvocation.ScriptLineNumber
    } 
    Function Mutex([scriptblock]$sb,[string]$mutex){
        $mt = new-object System.Threading.Mutex $false,$mutex
        If($mt.WaitOne()){
            $sb.Invoke();
            $mt.ReleaseMutex()
        }else{}
    }
    $basePath = (get-item $psscriptroot).parent.parent.FullName
    $basePathLogs = (get-item $psscriptroot).parent.parent.parent.FullName
    if($logsOnOff -eq 'On')
    {    
        Mutex {Out-File -FilePath "$logsPath" -InputObject $("$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), SourceLine=$line, SourceLineName=SetGV-$lineName, SetGVLine=$(LineNumber), SetGVLineName=SoundSetGVWasCalled, attribute=$attribute, value=$value, $logsPath") -append} "Logs"
    }
    Try{Remove-Module SoundGetGV}catch{}
    import-module "$basePath\Modules\SoundGetGV\SoundGetGV.psm1" -Function SoundGetGV -Scope global
    #import-module "$basePath\Modules\SoundResetGV\SoundResetGV.psm1" -Function SoundResetGV -Scope global
    Try
    {
        $hash = SoundGetGV "*" $null $line $lineName $logsPath | ConvertFrom-Json
    }
    catch
    {
        if($logsOnOff -eq 'On')
        {
            Mutex {Out-File -FilePath "$logsPath" -InputObject $("$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), SourceLine=$line, SourceLineName=SetGV-GetGVAllContentDidntWork-$lineName, SetGVLine=$(LineNumber), SetGVLineName=GetSoundGVAllContent, attribute=$attribute, value=$value, $logsPath") -append} "Logs"
        }
    }
    #Out-File -FilePath "$logsPath" -InputObject $hash -append
    Try{$hash.$attribute = $value}catch{}
    #Out-File -FilePath "$logsPath" -InputObject $hash -append
    $object = [PSCustomObject]$hash
    $Json = $object | ConvertTo-Json
    #Clear-Content -Path "$basePath\Sound\SoundConfig.txt"
    Try
    {
        Mutex {$Json | out-file "$basePath\Config\SoundConfig.txt"} "SoundSetGV"
    }
    Catch
    {
        if($logsOnOff -eq 'On')
        {
           Mutex {Out-File -FilePath "$logsPath" -InputObject $("$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), SourceLine=$line, SourceLineName=SetGV-OutFileDidntWork-$lineName, SetGVLine=$(LineNumber), SetGVLineName=SetAttributeValueinSoundConfig, attribute=$attribute, value=$value, $logsPath") -append} "Logs"
        }
        
    }
    if($logsOnOff -eq 'On')    
    {
        Mutex {Out-File -FilePath "$logsPath" -InputObject $("$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), SourceLine=$line, SourceLineName=SetGV-$lineName, SetGVLine=$(LineNumber), SetGVLineName=SoundSetGVWasSuccessful, attribute=$attribute, value=$value, $logsPath") -append} "Logs"
    }
}
Export-ModuleMember -Function SoundSetGV