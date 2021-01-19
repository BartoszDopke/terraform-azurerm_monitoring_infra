data "azurerm_subscription" "current" {}

locals {
  log_categories    = var.enable_diagnostics == true ? ["Administrative", "Security", "ServiceHealth", "Alert", "Recommendation", "Policy", "Autoscale", "ResourceHealth"] : []
  metric_categories = var.enable_diagnostics == true ? [] : []
  logs              = { for category in local.log_categories : category => (category) }
  metrics           = { for metric in local.metric_categories : metric => (metric) }

  templates = {
    template1 : {
      name             = "HPG-ALRT-${data.azurerm_subscription.current.display_name}-001-RESOURCEHEALTH"
      deployment_mode  = "Incremental"
      template_content = file("${path.module}/templates/CreateResourceHealthAlert.json")
      parameters_content = jsonencode({
        "actionGroups_name" = {
          value = azurerm_monitor_action_group.action_group.name
        }
        "activityLogAlerts_description" = {
          value = "Subscription: Resource Health alert - please review"
        }
        "activityLogAlerts_name" = {
          value = "HPG-ALRT-${data.azurerm_subscription.current.display_name}-001-RESOURCEHEALTH"
        }
      })
    },
    template2 : {
      name             = "HPG-ALRT-${data.azurerm_subscription.current.display_name}-001-SERVICEHEALTH"
      deployment_mode  = "Incremental"
      template_content = file("${path.module}/templates/CreateServiceHealthAlert.json")
      parameters_content = jsonencode({
        "actionGroups_name" = {
          value = azurerm_monitor_action_group.action_group.name
        }
        "activityLogAlerts_description" = {
          value = "Subscription: Service Health alert - please investigate"
        }
        "activityLogAlerts_name" = {
          value = "HPG-ALRT-${data.azurerm_subscription.current.display_name}-001-SERVICEHEALTH"
        }
      })
    }
  }
}

#-------------------------------------------------
# Action Group
#-------------------------------------------------

resource "azurerm_monitor_action_group" "action_group" {
  name                = upper(var.ag_name)
  resource_group_name = var.resource_group_name
  short_name          = var.short_name
  enabled             = var.enabled

  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name          = email_receiver.value.name
      email_address = email_receiver.value.email_address
    }
  }

  tags = var.tags
}

#-----------------------------------
# Diagnostic Settings for Subscription
#-----------------------------------
resource "azurerm_monitor_diagnostic_setting" "sub" {
  count                      = var.enable_sub_diagnostics == true ? 1 : 0
  name                       = "${data.azurerm_subscription.current.display_name}-DIAG-01"
  target_resource_id         = data.azurerm_subscription.current.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = local.logs
    content {
      category = log.key
      enabled  = true
      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  dynamic "metric" {
    for_each = local.metrics
    content {
      category = metric.key
      enabled  = true
      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  lifecycle {
    ignore_changes = [
      log_analytics_destination_type,
    ]
  }
}

resource "azurerm_monitor_activity_log_alert" "log_alert" {
  for_each            = var.enable_log_alert == true ? merge(var.log_criteria, var.custom_criteria) : {}
  name                = upper("HPG-ALRT-${data.azurerm_subscription.current.display_name}-001-${each.value.name}")
  resource_group_name = var.resource_group_name
  scopes              = [data.azurerm_subscription.current.id]
  description         = each.value.description

  criteria {
    category       = each.value.category
    operation_name = each.value.operation_name
    resource_type  = each.value.resource_type
  }

  action {
    action_group_id    = azurerm_monitor_action_group.action_group.id
    webhook_properties = var.webhook_properties
  }

  tags = var.tags
}

resource "azurerm_resource_group_template_deployment" "template" {
  for_each            = var.enable_arm_alert == true ? local.templates : {}
  name                = each.value.name
  resource_group_name = var.resource_group_name
  deployment_mode     = each.value.deployment_mode
  template_content    = each.value.template_content
  parameters_content  = each.value.parameters_content

  tags = var.tags
}