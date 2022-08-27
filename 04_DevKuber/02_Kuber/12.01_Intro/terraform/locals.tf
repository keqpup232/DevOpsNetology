locals {
  web_instance_each_map = {
    prod = {
      "master.kuber.netology.yc" = "node-master",
      "client.kuber.netology.yc" = "node-client"
    }
  }
}