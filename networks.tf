data "openstack_networking_network_v2" "public" {
  name = "public"
}

# Router for the whole project, linked to the public network
resource "openstack_networking_router_v2" "global" {
  name                = "global"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.public.id
}

# Internal Network
resource "openstack_networking_network_v2" "network" {
  name           = "my-network"
  admin_state_up = "true"
}

# Network Subnet
resource "openstack_networking_subnet_v2" "subnet" {
  name            = "my-network-subnet"
  network_id      = openstack_networking_network_v2.network.id
  cidr            = "192.168.1.0/24"
  ip_version      = 4
}

# Interface between Router and Subnet
resource "openstack_networking_router_interface_v2" "interface" {
  router_id = openstack_networking_router_v2.global.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

########### image

#resource "openstack_images_image_v2" "image" {
#  name             = "image"
#  image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
#  container_format = "bare"
#  disk_format      = "qcow2"
#}

############## instance

resource "openstack_compute_instance_v2" "instance" {
  name            = "instance"
  image_id        = "375ed21c-0c1e-45b8-8c83-a5556adcfff9"
  flavor_name       = "v2.m4.d10"
  security_groups = ["default"]

  network {
    name = openstack_networking_network_v2.network.name
  }
}

########### float ip

resource "openstack_networking_floatingip_v2" "float_ip_1" {
  pool = "public"
}

###########

#resource "openstack_networking_port_v2" "port_1" {
#  network_id = openstack_networking_network_v2.network.id
#  device_id = openstack_compute_instance_v2.instance.id
#}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.float_ip_1.address
  instance_id = openstack_compute_instance_v2.instance.id
}

