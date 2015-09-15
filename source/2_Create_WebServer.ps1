﻿configuration ConfigName {
    Node $ComputerName {

        WindowsFeature IIS{
            Name = 'web-server'
            Ensure = 'Present'
        }
    }
}
$computername = 'TestVM1','TestVM2'
ConfigName -OutputPath c:\DSC\Config

<#

Send configuration to target TestVM1, we use the -wait to prevent powershell running in a background job

Start-Process -FilePath iexplore http://TestVM2 #should fail
Start-DscConfiguration -Path C:\DSC\Config -ComputerName TestVM2 -Verbose -Wait
Test on S1 and S2 -- S2 should fail - no config

'TestVM1','TestVM2' | Foreach-Object {Start-Process -FilePath iexplore http://$_}

Now configure second VM
Start-DscConfiguration -Path C:\DSC\Config -ComputerName TestVM1 -Verbose -Wait

'TestVM1','TestVM2' | Foreach-Object {Start-Process -FilePath iexplore http://$_}
'TestVM1','TestVM2' | % {Start-Process -FilePath iexplore http://$_}

#>