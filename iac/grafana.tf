# This file contains the Terraform configuration for setting up Grafana dashboards.

# provider "grafana" {
#   url  = "http://grafana.local/"
#   auth = "admin:admin"
# }

# resource "grafana_contact_point" "discord" {
#   name = "Discord Alerts"

#   discord {
#     url = var.discord_webhook_url
#   }
# }

# resource "grafana_folder" "custom_alerts" {
#   title = "Custom Alerts"
# }

# resource "grafana_dashboard" "node_dashboard" {
#   config_json = <<EOT
# {
#   "title": "System Monitoring Dashboard",
#   "panels": [
#     {
#       "aliasColors": {},
#       "bars": false,
#       "dashLength": 10,
#       "dashes": false,
#       "datasource": {
#         "type": "prometheus",
#         "uid": "prometheus"
#       },
#       "fill": 1,
#       "fillGradient": 0,
#       "gridPos": {
#         "h": 8,
#         "w": 12,
#         "x": 0,
#         "y": 0
#       },
#       "hiddenSeries": false,
#       "id": 1,
#       "legend": {
#         "avg": false,
#         "current": false,
#         "max": false,
#         "min": false,
#         "show": true,
#         "total": false,
#         "values": false
#       },
#       "lines": true,
#       "linewidth": 1,
#       "nullPointMode": "null",
#       "options": {
#         "alertThreshold": true
#       },
#       "percentage": false,
#       "pluginVersion": "10.1.2",
#       "pointradius": 2,
#       "points": false,
#       "renderer": "flot",
#       "seriesOverrides": [],
#       "spaceLength": 10,
#       "stack": false,
#       "steppedLine": false,
#       "targets": [
#         {
#           "datasource": {
#             "type": "prometheus",
#             "uid": "prometheus"
#           },
#           "expr": "100 - avg(rate(node_cpu_seconds_total{mode=\"idle\"}[5m])) by (instance)",
#           "legendFormat": "{{instance}}",
#           "refId": "A"
#         }
#       ],
#       "thresholds": [],
#       "timeRegions": [],
#       "title": "CPU Usage",
#       "tooltip": {
#         "shared": true,
#         "sort": 0,
#         "value_type": "individual"
#       },
#       "type": "graph",
#       "xaxis": {
#         "mode": "time",
#         "show": true,
#         "values": []
#       },
#       "yaxes": [
#         {
#           "format": "short",
#           "logBase": 1,
#           "show": true
#         },
#         {
#           "format": "short",
#           "logBase": 1,
#           "show": true
#         }
#       ],
#       "yaxis": {
#         "align": false
#       }
#     },
#     {
#       "aliasColors": {},
#       "bars": false,
#       "dashLength": 10,
#       "dashes": false,
#       "datasource": {
#         "type": "prometheus",
#         "uid": "prometheus"
#       },
#       "fill": 1,
#       "fillGradient": 0,
#       "gridPos": {
#         "h": 8,
#         "w": 12,
#         "x": 12,
#         "y": 0
#       },
#       "hiddenSeries": false,
#       "id": 2,
#       "legend": {
#         "avg": false,
#         "current": false,
#         "max": false,
#         "min": false,
#         "show": true,
#         "total": false,
#         "values": false
#       },
#       "lines": true,
#       "linewidth": 1,
#       "nullPointMode": "null",
#       "options": {
#         "alertThreshold": true
#       },
#       "percentage": false,
#       "pluginVersion": "10.1.2",
#       "pointradius": 2,
#       "points": false,
#       "renderer": "flot",
#       "seriesOverrides": [],
#       "spaceLength": 10,
#       "stack": false,
#       "steppedLine": false,
#       "targets": [
#         {
#           "datasource": {
#             "type": "prometheus",
#             "uid": "prometheus"
#           },
#           "expr": "100 * (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes))",
#           "legendFormat": "{{instance}}",
#           "refId": "B"
#         }
#       ],
#       "thresholds": [],
#       "timeRegions": [],
#       "title": "Memory Usage",
#       "tooltip": {
#         "shared": true,
#         "sort": 0,
#         "value_type": "individual"
#       },
#       "type": "graph",
#       "xaxis": {
#         "mode": "time",
#         "show": true,
#         "values": []
#       },
#       "yaxes": [
#         {
#           "format": "short",
#           "logBase": 1,
#           "show": true
#         },
#         {
#           "format": "short",
#           "logBase": 1,
#           "show": true
#         }
#       ],
#       "yaxis": {
#         "align": false
#       }
#     },
#     {
#       "aliasColors": {},
#       "bars": false,
#       "dashLength": 10,
#       "dashes": false,
#       "datasource": {
#         "type": "prometheus",
#         "uid": "prometheus"
#       },
#       "fill": 1,
#       "fillGradient": 0,
#       "gridPos": {
#         "h": 8,
#         "w": 24,
#         "x": 0,
#         "y": 8
#       },
#       "hiddenSeries": false,
#       "id": 3,
#       "legend": {
#         "avg": false,
#         "current": false,
#         "max": false,
#         "min": false,
#         "show": true,
#         "total": false,
#         "values": false
#       },
#       "lines": true,
#       "linewidth": 1,
#       "nullPointMode": "null",
#       "options": {
#         "alertThreshold": true
#       },
#       "percentage": false,
#       "pluginVersion": "10.1.2",
#       "pointradius": 2,
#       "points": false,
#       "renderer": "flot",
#       "seriesOverrides": [],
#       "spaceLength": 10,
#       "stack": false,
#       "steppedLine": false,
#       "targets": [
#         {
#           "datasource": {
#             "type": "prometheus",
#             "uid": "prometheus"
#           },
#           "expr": "100 * (1 - sum(node_filesystem_avail_bytes{fstype!~\"tmpfs|overlay\"}) by (instance) / sum(node_filesystem_size_bytes{fstype!~\"tmpfs|overlay\"}) by (instance))",
#           "legendFormat": "{{instance}}",
#           "refId": "C"
#         }
#       ],
#       "thresholds": [],
#       "timeRegions": [],
#       "title": "Disk Usage",
#       "tooltip": {
#         "shared": true,
#         "sort": 0,
#         "value_type": "individual"
#       },
#       "type": "graph",
#       "xaxis": {
#         "mode": "time",
#         "show": true,
#         "values": []
#       },
#       "yaxes": [
#         {
#           "format": "short",
#           "logBase": 1,
#           "show": true
#         },
#         {
#           "format": "short",
#           "logBase": 1,
#           "show": true
#         }
#       ],
#       "yaxis": {
#         "align": false
#       }
#     }
#   ]
# }
# EOT
# }