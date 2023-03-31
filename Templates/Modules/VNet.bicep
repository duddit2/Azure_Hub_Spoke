// Parameter declarations
/////////////////////////////////////////////////////////

@description('Envirinment')
param env string

@description('Group name is created based on the product name and component being deployed')
param groupName string

@description('Virtual Network Address Range')
param addressPrefixes array

@description('Properties for all subnets in VNET')
param subnets array

@description('Custom DNS Servers for Virtual Network')
param dnsServers array

@description('Azure Region for deployment')
param location string

@description('Short name for the azure region')
param locationList object

@description('tags for project')
param tagValues object

@description('type of vnet (hub/spoke)')
param vnettype string


// Variables Section
////////////////////////////////////////////////////////////////////

var vnetName = '${vnettype}-vnet-${groupName}-${env}-${locationShortName}'
var locationShortName = locationList[location]
var dnsServersvar = {
        dnsServers: array(dnsServers)
        }


//resource declarations
////////////////////////////////////////////////////////////////////

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: vnetName
  location: location
  tags: tagValues
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    dhcpOptions: !empty(dnsServers) ? dnsServersvar : null
    subnets: [for subnet in subnets: {
      name: 'snet-${subnet.name}-${env}-${locationShortName}'
      properties: {
        addressPrefix: subnet.subnetPrefix
        serviceEndpoints: contains(subnet, 'serviceEndpoints') ? subnet.serviceEndpoints : []
        delegations: contains(subnet, 'delegation') ? subnet.delegation : []
        privateEndpointNetworkPolicies: contains(subnet, 'privateEndpointNetworkPolicies') ? subnet.privateEndpointNetworkPolicies : null
        privateLinkServiceNetworkPolicies: contains(subnet, 'privateLinkServiceNetworkPolicies') ? subnet.privateLinkServiceNetworkPolicies : null
        //networkSecurityGroup: contains(subnet, 'networkSecurityGroup') ? subnet.networkSecurityGroup : []
      }
    }]
  }
  
}

output vnetid string = virtualNetwork.id 
output vnetname string = virtualNetwork.name
