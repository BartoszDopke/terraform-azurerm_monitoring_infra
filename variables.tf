#------------------------------------------
#  Action Group
#------------------------------------------

variable "ag_name" {
  type    = string
  default = null
}

variable "resource_group_name" {
  type = string
}

variable "short_name" {
  type    = string
  default = null
}

variable "email_receivers" {
  type = list(object({
    name          = string
    email_address = string
  }))
  default = []
}

variable "enabled" {
  type    = bool
  default = true
}

variable "enable_diagnostics" {
  type    = bool
  default = true
}

variable "enable_sub_diagnostics" {
  type    = bool
  default = true
}

#-------------------------------------------------------
# Activity Log Alerts
#-------------------------------------------------------

variable "enable_log_alert" {
  type    = bool
  default = false
}

variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "log_criteria" {
  type = map(object({
    name           = string
    description    = string
    category       = string
    operation_name = string
    resource_type  = string
  }))
  default = {
    "KVMOD" = {
      name           = "KVMOD"
      description    = "Keyvault: Modifying - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.KeyVault/vaults/write"
      resource_type  = "Microsoft.KeyVault/vaults"
    },
    "KVDEL" = {
      name           = "KVDEL"
      description    = "Keyvault: Deleting - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.KeyVault/vaults/delete"
      resource_type  = "Microsoft.KeyVault/vaults"
    },
    "NSGMOD" = {
      name           = "NSGMOD"
      description    = "Network Security Group: Modifying - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.Network/networkSecurityGroups/write"
      resource_type  = "Microsoft.Network/networksecuritygroups"
    },
    "VMSTART" = {
      name           = "VMSTART"
      description    = "Virtual Machines: Starting - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.Compute/virtualMachines/start/action"
      resource_type  = "Microsoft.Compute/virtualMachines"
    },
    "VMSTOP" = {
      name           = "VMSTOP"
      description    = "Virtual Machines: Stopping - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.Compute/virtualMachines/powerOff/action"
      resource_type  = "Microsoft.Compute/virtualMachines"
    },
    "VMRESTART" = {
      name           = "VMRESTART"
      description    = "Virtual Machines: Restarting - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.Compute/virtualMachines/restart/action"
      resource_type  = "Microsoft.Compute/virtualMachines"
    },
    "VMDEALL" = {
      name           = "VMDEALL"
      description    = "Virtual Machines: Deallocating - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.Compute/virtualMachines/deallocate/action"
      resource_type  = "Microsoft.Compute/virtualMachines"
    },
    "VMDEL" = {
      name           = "VMDEL"
      description    = "Virtual Machines: Deleting - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.Compute/virtualMachines/delete"
      resource_type  = "Microsoft.Compute/virtualMachines"
    },
    "VMMTNCDEP" = {
      name           = "VMMTNCDEP"
      description    = "Virtual Machines: Maintenance Redeploy - please investigate"
      category       = "Administrative"
      operation_name = "Microsoft.Compute/virtualMachines/performMaintenance/action"
      resource_type  = "Microsoft.Compute/virtualMachines"
    }
  }
}

variable "custom_criteria" {
  type = map(object({
    name           = string
    description    = string
    category       = string
    operation_name = string
    resource_type  = string
  }))
  default = {
    # "FWMOD" = {
    #   name           = "FWMOD"
    #   description    = "Firewall: Modifying - please investigate"
    #   category       = "Administrative"
    #   operation_name = "Microsoft.Network/azureFirewalls/write"
    #   resource_type  = "Microsoft.Network/azureFirewalls"
    # },
    # "FWDEL" = {
    #   name           = "FWDEL"
    #   description    = "Firewall: Deleting - please investigate"
    #   category       = "Administrative"
    #   operation_name = "Microsoft.Network/azureFirewalls/delete"
    #   resource_type  = "Microsoft.Network/azureFirewalls"
    # },
  }
}

#OPTIONAL

variable "webhook_properties" {
  type    = map(any)
  default = {}
}


#-------------------------------------------------------
# ARM Template Alerts
#-------------------------------------------------------

variable "enable_arm_alert" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(any)
  default = null
}