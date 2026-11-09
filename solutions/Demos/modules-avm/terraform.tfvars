resource_group_name = "rg-avm-demo"
location            = "denmarkeast"

vnet_name = "vnet-avm-demo"

address_space = [
  "10.10.0.0/16"
]

web_subnet_name = "snet-web"

web_subnet_prefixes = [
  "10.10.1.0/24"
]

app_subnet_name = "snet-app"

app_subnet_prefixes = [
  "10.10.2.0/24"
]

data_subnet_name = "snet-data"

data_subnet_prefixes = [
  "10.10.3.0/24"
]

enable_telemetry = false

tags = {
  Environment = "Demo"
  ManagedBy   = "Terraform"
  Purpose     = "AVM-Training"
}