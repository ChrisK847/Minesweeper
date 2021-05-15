function SoundGetGV($attribute,$index,$line,$lineName,$logsPath){
    $ErrorActionPreference = 'Stop'
    $logsOnOff = 'On' #On or Off

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

    Try
    {
        $Content = Get-Content "$basePath\Config\SoundConfig.txt" -Raw;
        if($logsOnOff -eq 'On')
        {
            mutex {Out-File -FilePath "$logsPath" -InputObject "$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), SourceLine=$line, SourceLineName=GetGV-$lineName, GetGVLine=$(lineNumber), GetGVLineName=GetContentGetGVfromSoundConfig, attribute=$attribute, index=$index, logsPath=$logsPath" -Append} "Logs"
        }
    }
    Catch
    {
        if($logsOnOff -eq 'On')
        {
            Mutex {Out-File -FilePath "$logsPath" -InputObject "$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), SourceLine=$line, SourceLineName=GetGV-GetContentFailed-$lineName, GetGVLine=$(lineNumber), GetGVLineName=GetContent, attribute=$attribute, index=$index, SoundConfigContent=$Content, logsPath=$logsPath" -Append} "Logs"
        }
    }
    if($Content.Length -lt 1){
        if($logsOnOff -eq 'On')
        {
	        Mutex {Out-File -FilePath "$logsPath" -InputObject "$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), SourceLine=$line, SourceLineName=GetGV-$lineName, GetGVLine=$(lineNumber), GetGVLineName=SoundConfigLengthLessThan1, attribute=$attribute, index=$index, SoundConfigContent=$Content, logsPath=$logsPath" -Append} "Logs"
        }
        exit
        #import-module "$basePath\Modules\SoundResetGV\SoundResetGV.psm1" -Function SoundResetGV
        #SoundResetGV #Temporarily disabled to troubleshoot what is causing blank SoundConfig.txt file 2/5/2021
    }Else{
        #Out-File -FilePath "$logsPath" -InputObject "$(Get-Date -Format "MM/dd/yyyy HH:mm:ss.fff"), Line=$line, LineName=$lineName, attribute=$attribute, index=$index, content=$Content, logsPath=$logsPath" -Append
    }
    $PSCustomObj = $Content | Out-String | ConvertFrom-Json
    #Out-File -FilePath "$logsPath" -InputObject "attribute=$attribute,pscustomobj=$($PSCustomObj.SoundSettings | Get-Member | Format-Table * | Out-string)"
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