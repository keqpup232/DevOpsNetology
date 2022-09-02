locals {
  web_instance_each_map = {
    prod = {
      "master01.kuber.netology.yc" = "node-master-01",
      "master02.kuber.netology.yc" = "node-master-02",
      "master03.kuber.netology.yc" = "node-master-03",
      "worker01.kuber.netology.yc" = "node-worker-01",
      "worker02.kuber.netology.yc" = "node-worker-02",
      "worker03.kuber.netology.yc" = "node-worker-03",
      "worker04.kuber.netology.yc" = "node-worker-04"
    }
  }
}