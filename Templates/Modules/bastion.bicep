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

@description('subnet ID where the bastion will be deployed')
param subNetID string


//Variables declarations
/////////////////////////////////////////////////////

var bastionName = 'bas-${groupName}-${env}-${locationShortName}'
var locationShortName = locationList[location]
var pip_name = '${bastionName}-pip'


//Resource Declarations
/////////////////////////////////////////////////////

resource bastion_pip 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: pip_name
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion:'IPv4'
    
  }
  tags: tagValues
}

resource bastionService 'Microsoft.Network/bastionHosts@2022-07-01' = {
  name: bastionName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'ipconf'
        properties: {
          publicIPAddress: {
            id: bastion_pip.id
          }
          subnet: {
            id: subNetID
          }
        }
      }
    ]
  }
  tags: tagValues

}

output bastionId string = bastionService.id
