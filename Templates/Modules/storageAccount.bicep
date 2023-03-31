//Parameters declarations
/////////////////////////////////////////////////////

@description('partial name of SA')
param name string

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

@description('fileshare array')
param fileshares array

@description('SKU Kind')
@allowed([
  'FileStorage'
  'Storage'
  'StorageV2'
])
param Kind string = 'StorageV2'

@description('SKU of Storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'


//Variables declarations
/////////////////////////////////////////////////////

var StorageAccountName = 'sa-${name}-${env}-${locationShortName}'
var locationShortName = locationList[location]


//Resource Declarations
/////////////////////////////////////////////////////

resource SA 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: StorageAccountName
  location: location
  kind: Kind
  tags: tagValues
  sku: {
    name: storageSKU
    
  }
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
  }

  resource fileservices 'fileServices' = {
    name: 'default'
    properties: {      
    }

    resource shares 'shares' = [for fs in fileshares: {
      name: fs
      properties: {
        accessTier: 'TransactionOptimized'
        enabledProtocols: 'SMB'
      }
    }]
  }
  
}
