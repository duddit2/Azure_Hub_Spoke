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
module ukWestSpoke 'Templates/Modules/VNet.bicep' = {
  name: 'DeployUKWSpoke'
  params: {
    addressPrefixes: ukwspoke.addressPrefixes
    dnsServers: ukwspoke.dnsServers
    env: env
    groupName: groupName
    vnettype: ukwspoke.vnettype
    location: ukwspoke.location
    locationList: locationList
    subnets: ukwspokeSubnets
    tagValues: tagValues
  }
}

output ukwVnetID string = ukWestSpoke.outputs.vnetid
output ukwVnetName string = ukWestSpoke.outputs.vnetname


