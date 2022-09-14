locals {
  web_instance_each_map = {
    prod = {
      "master01.kuber.netology.yc" = "node-master-01",
      "worker01.kuber.netology.yc" = "node-worker-01",
      "worker02.kuber.netology.yc" = "node-worker-02"
    }
  }
}