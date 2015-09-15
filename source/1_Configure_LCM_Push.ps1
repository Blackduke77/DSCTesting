##########################################################################################################################
# Set Local Configuration Manager configuration mode from defaul (ApplyAndMonitor) to ApplyAndAutoCorrect
# This method is the new way of setting the LCM, this configures the management agent
# configures the meta data configuration and generates a xx.meta.mof which is deployed via set-dsclocalconfigurationmanger
# I ran this against Windows Server 2012 R2, which required updating to the lastest Windows Management Framework
# https://www.microsoft.com/en-us/download/confirmation.aspx?id=46889
##########################################################################################################################

# create fuction to update configuration mode and refresh mode for Variable $Computername
[DSCLocalConfigurationManager()]
Configuration LCMPUSH 
{	
	Node $Computername
	{
		SEttings
		{
			AllowModuleOverwrite = $True
            ConfigurationMode = 'ApplyAndAutoCorrect'
			RefreshMode = 'Push'	
		}
	}
}

# step 1
# Generates configuration for below computer variable
$Computername = 'TestVM1','TestVM2'

# Creates the Computer.Meta.Mof in folder below
LCMPush -OutputPath c:\DSC\LCM

#View output files in ISE and explorer
Explorer C:\dsc\LCM\
ise c:\DSC\LCM\TestVM1.meta.mof #View 
ise c:\DSC\LCM\TestVM2.meta.mof #View


# Step 2
# Set the LCM on two remote targets, this does not need to be run locally on the remote server, the below was run remotely

Set-DSCLocalConfigurationManager -ComputerName $computername -Path c:\DSC\LCM –Verbose

#Show change
Get-DscLocalConfigurationManager -CimSession $Computername

#Show configuration file location on TestVM1
Explorer \\TestVM1\c$\windows\system32\Configuration
#Show configuration file location on TestVM2
Explorer \\TestVM2\c$\windows\system32\Configuration

