module "k8s_prod_cluster2" {
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version                         = "17.2.0"
  project_id                      = var.project_id
  name                            = "k8s-${var.env_name}-cluter2"
  regional                        = true
  region                          = var.region
  zones                           = var.node_locations
  network                         = "${var.network}-${var.env_name}"
  # network_project_id              = var.network_project_id #trường này dành cho organization
  subnetwork                      = "${var.subnetwork}-${var.env_name}"
  ip_range_pods                   = var.ip_range_pods_name
  ip_range_services               = var.ip_range_services_name
  enable_private_endpoint         = true
  enable_private_nodes            = true
  network_policy                  = false
  issue_client_certificate        = false
  remove_default_node_pool        = true
  master_global_access_enabled    = false
  kubernetes_version              = "1.22.8-gke.201"
  master_ipv4_cidr_block          = var.master_cidr
  service_account                 = var.compute_engine_service_account
  create_service_account          = false
  maintenance_start_time          = "19:00"
  identity_namespace              = "${var.project_id}.svc.id.goog"
  node_metadata                   = "GKE_METADATA_SERVER"
  enable_shielded_nodes           = false
  dns_cache                       = true
  enable_vertical_pod_autoscaling = true
  gce_pd_csi_driver               = true
  datapath_provider               = "DATAPATH_PROVIDER_UNSPECIFIED"

  master_authorized_networks = [
    {
      cidr_block   = "10.0.0.0/8"
      display_name = "subnet-vm-common-prod"
    },
  ]

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-custom-4-4096"
      version            = "1.22.8-gke.201"
      min_count          = 0
      max_count          = 4
      disk_size_gb       = 40
      disk_type          = "pd-ssd"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = false
      preemptible        = false
      initial_node_count = 1
    },
    # {
    #   name               = "preemptible-node-pool"
    #   machine_type       = "e2-custom-4-4096"
    #   version            = "1.21.11-gke.1100"
    #   min_count          = 0
    #   max_count          = 10
    #   disk_size_gb       = 100
    #   disk_type          = "pd-ssd"
    #   image_type         = "COS"
    #   auto_repair        = true
    #   auto_upgrade       = false
    #   preemptible        = true
    #   initial_node_count = 1
    # },
  #   {
  #     name         = "std8"
  #     machine_type = "e2-standard-8"
  #     version      = "1.19.10-gke.1600"
  #     min_count    = 0
  #     min_count    = 0
  #     max_count    = 2
  #     disk_size_gb = 60
  #     disk_type    = "pd-ssd"
  #     image_type   = "COS"
  #     auto_repair  = true
  #     auto_upgrade = false
  #     preemptible  = true
  #   },
    # {
    #   name           = "android-agent"
    #   machine_type   = "e2-custom-4-4096"
    #   version        = "1.19.10-gke.1600"
    #   node_locations = "asia-southeast1-b"
    #   min_count      = 0
    #   max_count      = 6
    #   disk_size_gb   = 30
    #   disk_type      = "pd-balanced"
    #   image_type     = "COS"
    #   auto_repair    = true
    #   auto_upgrade   = false
    #   preemptible    = false
    # },
  #   {
  #     name           = "redis"
  #     machine_type   = "e2-custom-2-8192"
  #     version        = "1.19.14-gke.1900"
  #     node_locations = "asia-southeast1-b"
  #     disk_size_gb   = 30
  #     disk_type      = "pd-balanced"
  #     image_type     = "COS_CONTAINERD"
  #     autoscaling    = true
  #     min_count      = 0
  #     max_count      = 20
  #     auto_repair    = true
  #     auto_upgrade   = false
  #     preemptible    = false
  #   },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/cloud_debugger",
    ]
  }

  node_pools_labels = {
    all = {
      env = "production"
      app = "cluster2"
    }
    default-node-pool = {
      default-node-pool = "1"
    }
    # preemptible-node-pool = {
    #   preemptible-pool = "1"
    # }
    # android-agent = {
    #   android-agent = "true"
    # }
  #   redis = {
  #     "tiki.services/preemptible" = "false"
  #     "tiki.services/dedicated"   = "redis"
  #   }
  }

  node_pools_metadata = {
    all = {}
  }

  # node_pools_taints = {
  #   std8 = [
  #     {
  #       key    = "dedicated"
  #       value  = "std8"
  #       effect = "NO_SCHEDULE"
  #     },
  #   ]
    # android-agent = [
    #   {
    #     key    = "dedicated"
    #     value  = "android-agent"
    #     effect = "NO_SCHEDULE"
    #   },
    # ]
    # redis = [
    #   {
    #     key    = "dedicated"
    #     value  = "redis"
    #     effect = "NO_SCHEDULE"
    #   }
    # ]
  # }

  node_pools_tags = {
    all = []
    default-node-pool = [
      "default-node-pool",
    ]
    # preemptible-node-pool = [
    #   "preemptible-node-pool",
    # ]
  }
}

#------------------------------------------------------------------------------
# IAM role for k8s clusters
#------------------------------------------------------------------------------
# module "iam_prod_cluster_stackdriver_agent_roles" {
#   source  = "terraform-google-modules/iam/google//examples/stackdriver_agent_roles"
#   version = "3.0.0"

#   project               = var.project_id
#   service_account_email = var.compute_engine_service_account
# }

# resource "google_project_iam_member" "k8s_stackdriver_metadata_writer" {
#   role    = "roles/stackdriver.resourceMetadata.writer"
#   member  = "serviceAccount:${var.compute_engine_service_account}"
#   project = var.project_id
# }
