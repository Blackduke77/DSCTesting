##########################################################################################################################
#Set Local Configuration Manager configuration mode from defaul (ApplyAndMonitor) to ApplyAndAutoCorrect
#This method is the new way of setting the LCM, this configures the management agent
#configures the meta data configuration and generates a xx.meta.mof which is deployed via set-dsclocalconfigurationmanger
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

# Generates configuration for below Variable
$Computername = 'TestVM1','TestVM2'

# Creates the Computer.Meta.Mof in folder below
LCMPush -OutputPath c:\DSC\LCM




