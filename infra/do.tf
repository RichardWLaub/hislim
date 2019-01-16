resource "digitalocean_kubernetes_cluster" "slim" {
  name    = "slim"
  region  = "sfo2"
  version = "1.13.1-do.2"
  tags    = ["slim"]

  node_pool {
    name       = "woker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}

resource "digitalocean_domain" "default" {
  name       = "jupyter.hi-slim.tk"
  ip_address = "${kubernetes_service.slim.load_balancer_ingress.0.ip}"
}
