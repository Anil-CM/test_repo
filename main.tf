provider "ibm" {
  generation = 1
}

locals {
  ZONE = "us-south-1"
}

data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

resource "ibm_container_vpc_cluster" "cluster" {
  name              = "us-test-1"
  vpc_id            = "71ac0bbb-008e-46b1-96d3-66741c163a46"
  flavor            = var.flavor
  worker_count      = var.worker_count
  disable_public_service_endpoint = true
  resource_group_id = data.ibm_resource_group.resource_group.id

  zones {
    name      = local.ZONE
    subnet_id = "bd58de33-7639-43f8-914b-524042b3ab50"
  }
  
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = ibm_container_vpc_cluster.cluster.id
}

