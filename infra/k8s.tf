provider "kubernetes" {
  host = "${digitalocean_kubernetes_cluster.slim.endpoint}"

  client_certificate     = "${base64decode(digitalocean_kubernetes_cluster.slim.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(digitalocean_kubernetes_cluster.slim.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.slim.kube_config.0.cluster_ca_certificate)}"
}

resource "kubernetes_deployment" "slim" {
  metadata {
    name = "slim"

    labels {
      app = "jupyter"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels {
        app = "jupyter"
      }
    }

    template {
      metadata {
        labels {
          app = "jupyter"
        }
      }

      spec {
        container {
          image = "rwlaub/hislim:1"
          name  = "slim"
        }
      }
    }
  }
}

resource "kubernetes_service" "slim" {
  metadata {
    name = "slim"
  }

  spec {
    selector {
      app = "jupyter"
    }

    session_affinity = "ClientIP"

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
