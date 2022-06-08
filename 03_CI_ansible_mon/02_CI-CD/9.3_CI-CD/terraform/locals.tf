locals {
  web_instance_each_map = {
    prod = {
      "sonar.netology.yc" = "node-sonar",
      "nexus.netology.yc" = "node-nexus"
    }
  }
}