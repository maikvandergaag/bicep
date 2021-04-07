# Script for deploying the arm templates generated via bicep


#Login

Login-AzAccount
Set-AzContext -Subscription "b27ac091-3de5-46d1-8f61-add3171f6e52"

#001
Write-Host "Starting build and deployment 001"
bicep build ".\001-webapp-insights\001-webapp-insights.bicep"

New-AzResourceGroup -Name "sb-bicep-001" -Location "westeurope" -Force
New-AzResourceGroupDeployment -TemplateFile ".\001-webapp-insights\001-webapp-insights.json" `
 -Location "westeurope" `
 -ResourceGroupName "sb-bicep-001" `
 -appServicePlanName "azhosting-biceptest" `
 -websiteName "azapp-biceptest" `
 -appInsightsName "azinsights-biceptest" `
 -logAnalyticsName "azlog-biceptest"

#002
Write-Host "Starting build and deployment 002"
bicep build ".\002-use-module\002-use-module.bicep"

New-AzResourceGroup -Name "sb-bicep-002" -Location "westeurope" -Force
New-AzResourceGroupDeployment -TemplateFile ".\002-use-module\002-use-module.bicep" -Location "westeurope" -ResourceGroupName "sb-bicep-002"

# 003
Write-Host "Starting build and deployment 003"
bicep build ".\003-resourcegroup-module\003-resourcegroup-module.bicep"

New-AzDeployment -TemplateFile ".\003-resourcegroup-module\003-resourcegroup-module.json" -Name "bicep-test" -Location "westeurope" -appRGName "sb-bicep-003" -rglocation "westeurope"

# 004
Write-Host "Starting build and deployment 004"
bicep build ".\004-multiple-vm\004-multiple-vm.bicep"

$password = ConvertTo-SecureString -String "123$%gddTYG&" -AsPlainText -Force
New-AzDeployment -TemplateFile ".\004-multiple-vm\004-multiple-vm.json" -Name "bicep-test" -Location "westeurope" -virtualNetworkName "azvnet-bicep" -password $password -count 4 -rgName "sb-bicep-004"

# 005
Write-Host "Starting build and deployment 005"
bicep build ".\005-multiple-vm-array\005-multiple-vm-array.bicep"

$password = ConvertTo-SecureString -String "123$%gddTYG&" -AsPlainText -Force
$vmItems = @('azvmbicep001', 'azvmbicep002', 'azvmbicep003')
New-AzDeployment -TemplateFile ".\005-multiple-vm-array\005-multiple-vm-array.json" -Name "bicep-test" -Location "westeurope" -virtualNetworkName "azvnet-bicep" -password $password -vmItems $vmItems -rgName "sb-bicep-005"

