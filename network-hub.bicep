//General Information 
/////////////////////////////////////
param env string
param groupName string
param locationList object
param tagValues object

//Network Information
/////////////////////////////////////
param HubVNet object
param HubSubnets array
param ukwspoke object
param ukwspokeSubnets array


//Modules
/////////////////////////////////////
module hub 'Templates/Modules/VNet.bicep' = {
  name: 'DeployHub'
  params: {
    addressPrefixes: HubVNet.addressPrefixes
    dnsServers: HubVNet.dnsServers
    env: env
    groupName: groupName
    vnettype: HubVNet.vnettype
    location: HubVNet.location
    locationList: locationList
    subnets: HubSubnets
    tagValues: tagValues
  }
  
}

output hubID string = hub.outputs.vnetid
output hubName string = hub.outputs.vnetname
