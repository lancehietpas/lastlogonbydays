﻿import-module activedirectory  
$domain = "domain"  
$DaysInactive = 90  
$time = (Get-Date).Adddays(-($DaysInactive)) 
  
# Get all AD User with lastLogonTimestamp less than our time and set to enable 
Get-ADUser -Filter {LastLogonTimeStamp -lt $time -and enabled -eq $true} -Properties LastLogonTimeStamp | 
  
# Output Name and lastLogonTimestamp into CSV  
select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd_hh:mm:ss')}} | export-csv C:\ -notypeinformation