function AddRemoveGV($AddRemove,$user,$difficulty,$rows,$mute){
    #Get Current File's GV's
    #.'\GetGV.ps1'
    $basePath = (get-item $psscriptroot).parent.FullName
    import-module "$basePath\Config\GetGV.psm1" -Function GetGV
    import-module "$basePath\Config\ResetGV.psm1" -Function ResetGV
    $hash = GetGV "*" "*" | ConvertFrom-Json
    if($hash.GlobalVariables.Count -eq 0 -or $hash.GlobalVariables.Count -eq $null){
        ResetGV
        #Add-content "$basePath\Logs\ResetGVActivated.txt" "Activated"
	$hash = GetGV "*" "*" | ConvertFrom-Json
    }
       #Add-content "$basePath\Logs\ResetGVActivated.txt" "Activated"
        $i = 1
        ForEach($hashette in $hash.GlobalVariables){
            If($hashette.User -eq $user){
                
                If($AddRemove -eq "Add"){
                    Write-host "User already exists. Please change your user name and try again."
                    Break
                }elseif($AddRemove -eq "Remove"){
                    $hash.GlobalVariables = $hash.GlobalVariables | Where-Object{$_.User -notlike $hashette.User}
		    if($hash.GlobalVariables.Count -eq 0 -or $hash.GlobalVariables.Count -eq $null){
	                ResetGV
                        #Add-Content "$basePath\Logs\AddRemoveGV.txt" "hash = $hash, hash.GlobalVariables = $hash.GlobalVariables, hashette = $hashette, addRemove = $AddRemove, user = $user, difficulty = $difficulty, mute = $mute"
		    }
                }else{
                    Write-host "Please specify whether you want to add or remove user."
                }

            }else{
	        
                If($i -eq $hash.GlobalVariables.Count){
                    If($AddRemove -eq "Add"){
	                    
			    $hash.GlobalVariables += @{
				User = $user;
				Difficulty = $difficulty;
				Rows = $rows;
				Mute = $mute;
			    }
			    
                    }elseif($AddRemove -eq "Remove"){
                        Write-host "User either already removed or doesn't exist. Please investigate."
                    }
	        }
            }
	    $i = $i + 1
        }

    $object = [PSCustomObject]$hash
    $Json = $object | ConvertTo-Json
    Clear-Content -Path "$basePath\Config\GV.txt"
    
    $Json | out-file "$basePath\Config\GV.txt"
}
Export-ModuleMember -Function AddRemoveGV
#cls
#AddGV "Add" "Joe" "4" "2" "true"