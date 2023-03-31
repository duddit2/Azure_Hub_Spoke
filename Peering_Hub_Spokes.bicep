param hubVnetName string
param ukwestspoke string


module peerFirstVnetSecondVnet 'Templates/Modules/VNetPeering.bicep' = {
  name: 'peerFirstToSecond'
  params: {
    existingLocalVirtualNetworkName: hubVnetName
    existingRemoteVirtualNetworkName: ukwestspoke
    existingRemoteVirtualNetworkResourceGroupName: resourceGroup().name
  }
}

module peerSecondVnetFirstVnet 'Templates/Modules/VNetPeering.bicep' = {
  name: 'peerSecondToFirst'
  params: {
    existingLocalVirtualNetworkName: ukwestspoke
    existingRemoteVirtualNetworkName: hubVnetName
    existingRemoteVirtualNetworkResourceGroupName: resourceGroup().name
    
  }
}
