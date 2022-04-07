locals {
  web_instance_type_map = {
    stage = "t3.micro"
    prod = "t3.large"
  }
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
  web_instance_each_map = {
    stage = {
      "first" = "t3.micro"
    }
    prod = {
      "first" = "t3.large",
      "second" = "t3.large"
    }
  }
}
