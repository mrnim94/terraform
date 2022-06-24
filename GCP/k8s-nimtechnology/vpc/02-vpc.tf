module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version = "5.1.0"
  project_id   = var.project_id
  network_name = "${var.network}-${var.env_name}"
  routing_mode = "GLOBAL"
  delete_default_internet_gateway_routes = true
  subnets = [
    {
      subnet_name   = "${var.subnetwork}-${var.env_name}"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.region
      subnet_private_access = "true"
    },
    //cluter2
    {
      subnet_name   = "${var.subnetwork_other}-${var.env_name}"
      subnet_ip     = "10.12.0.0/16"
      subnet_region = var.region
      subnet_private_access = "true"
    },
  ]

  routes = [
    {
      name              = "${var.subnetwork}-egress-internet"
      description       = "Default route to the Internet"
      destination_range = "0.0.0.0/0"
      next_hop_internet = "true"
    },
  ]
  secondary_ranges = {
    "${var.subnetwork}-${var.env_name}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "10.30.0.0/16"
      },
    ],
    //cluter 2
    "${var.subnetwork_other}-${var.env_name}" = [
      {
        range_name    = var.ip_range_pods_name_other
        ip_cidr_range = "10.22.0.0/16"
      },
      {
        range_name    = var.ip_range_services_name_other
        ip_cidr_range = "10.32.0.0/16"
      },
    ]
  }

  //cluster2

}