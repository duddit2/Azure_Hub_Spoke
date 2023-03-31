//Parameters declarations
/////////////////////////////////////////////////////

@description('location of bastion service')
param location string

@description('Short name for the azure region')
param locationList object

@description('tags of bastion service')
param tagValues object

@description('environment')
param env string

@description('Group name is created based on the product name and component being deployed')
param groupName string 

@description('NSGRules')
param securityRules object

//Variables declarations
/////////////////////////////////////////////////////

var NSGName = 'NSG-${groupName}-${env}-${locationShortName}'
var locationShortName = locationList[location]

//Resource Declarations
/////////////////////////////////////////////////////

resource nsg 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: NSGName
  location: location
  properties: {
    securityRules: [
      securityRules
    ]
  }
  tags: tagValues
}

output NSGid string = nsg.id
