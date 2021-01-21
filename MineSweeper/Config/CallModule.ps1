cls
Remove-Module "GetGV"
import-module "$psscriptroot\GetGV.psm1" -Function GetGV

write-host "en = $(GetGV '*' 'User')"



########################################
write-host "nn = $(GetGV 'Chris' 'User')"
write-host "ne = $(GetGV 'Chris' '*')"
GetGV '*' '*'