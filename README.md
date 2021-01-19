## Requirements   

No requirements.  

## Providers      

| Name | Version |
|------|---------|
| azurerm | n/a | 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ag\_name | n/a | `string` | `null` | no |
| custom\_criteria | n/a | <pre>map(object({<br>    name           = string<br>    description    = string<br>    category       = string<br>    operation_name = string<br>    resource_type  = string<br>  }))</pre> | `{}` | no |
| email\_receivers | n/a | <pre>list(object({<br>    name          = string<br>    email_address = string<br>  }))</pre> | `[]` | no |
| enable\_arm\_alert | n/a | `bool` | `true` | no |
| enable\_diagnostics | n/a | `bool` | `true` | no |
| enable\_log\_alert | n/a | `bool` | `false` | no |
| enable\_sub\_diagnostics | n/a | `bool` | `true` | no |
| enabled | n/a | `bool` | `true` | no |
| log\_analytics\_workspace\_id | n/a | `string` | `null` | no |
| log\_criteria | n/a | <pre>map(object({<br>    name           = string<br>    description    = string<br>    category       = string<br>    operation_name = string<br>    resource_type  = string<br>  }))</pre> | <pre>{<br>  "KVDEL": {<br>    "category": "Administrative",<br>    "description": "Keyvault: Deleting - please investigate",<br>    "name": "KVDEL",<br>    "operation_name": "Microsoft.KeyVault/vaults/delete",<br>    "resource_type": "Microsoft.KeyVault/vaults"<br>  },<br>  "KVMOD": {<br>    "category": "Administrative",<br>    "description": "Keyvault: Modifying - please investigate",<br>    "name": "KVMOD",<br>    "operation_name": "Microsoft.KeyVault/vaults/write",<br>    "resource_type": "Microsoft.KeyVault/vaults"<br>  },<br>  "NSGMOD": {<br>    "category": "Administrative",<br>    "description": "Network Security Group: Modifying - please investigate",<br>    "name": "NSGMOD",<br>    "operation_name": "Microsoft.Network/networkSecurityGroups/write",<br>  
  "resource_type": "Microsoft.Network/networksecuritygroups"<br>  },<br>  "VMDEALL": {<br>    "category": "Administrative",<br>    "description": "Virtual Machines: Deallocating - please investigate",<br>    "name": "VMDEALL",<br>    "operation_name": "Microsoft.Compute/virtualMachines/deallocate/action",<br>    "resource_type": "Microsoft.Compute/virtualMachines"<br>  },<br>  "VMDEL": {<br>    "category": "Administrative",<br>    "description": "Virtual Machines: Deleting - please investigate",<br>    "name": "VMDEL",<br>    "operation_name": "Microsoft.Compute/virtualMachines/delete",<br>    "resource_type": "Microsoft.Compute/virtualMachines"<br>  },<br>  "VMMTNCDEP": {<br>    "category": "Administrative",<br>    "description": "Virtual Machines: Maintenance Redeploy - please investigate",<br>    "name": "VMMTNCDEP",<br>    "operation_name": "Microsoft.Compute/virtualMachines/performMaintenance/action",<br>    "resource_type": "Microsoft.Compute/virtualMachines"<br>  
},<br>  "VMRESTART": {<br>    "category": "Administrative",<br>    "description": "Virtual Machines: Restarting - please investigate",<br>    "name": "VMRESTART",<br>    "operation_name": "Microsoft.Compute/virtualMachines/restart/action",<br>    "resource_type": "Microsoft.Compute/virtualMachines"<br>  },<br>  "VMSTART": {<br>    "category": "Administrative",<br>    "description": "Virtual 
Machines: Starting - please investigate",<br>    "name": "VMSTART",<br>    "operation_name": "Microsoft.Compute/virtualMachines/start/action",<br>    "resource_type": "Microsoft.Compute/virtualMachines"<br>  },<br>  "VMSTOP": {<br>    "category": "Administrative",<br>    "description": "Virtual Machines: Stopping - please investigate",<br>    "name": "VMSTOP",<br>    "operation_name": "Microsoft.Compute/virtualMachines/powerOff/action",<br>    "resource_type": "Microsoft.Compute/virtualMachines"<br>  }<br>}</pre> | no |
| resource\_group\_name | n/a | `string` | n/a | yes |
| short\_name | n/a | `string` | `null` | no |
| tags | n/a | `map(any)` | `null` | no |
| webhook\_properties | n/a | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| action\_group\_id | n/a |
| action\_group\_name | n/a |
