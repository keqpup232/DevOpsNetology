locals {
  web_instance_type_map = {
    stage = "standard-v1"
    prod = "standard-v3"
  }
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
  web_instance_each_map = {
    stage = {
      "first" = "standard-v1"
    }
    prod = {
      "first" = "standard-v3",
      "second" = "standard-v3"
    }
  }
}
