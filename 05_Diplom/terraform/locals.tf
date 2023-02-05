locals {
  web_instance_each_map = {
    prod = {
      "kuber-master01.netology.yc" = {name="kuber-master01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8snjpoq85qqv0mk9gi", size=50, user="ubuntu"},
      "kuber-worker01.netology.yc" = {name="kuber-worker01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8snjpoq85qqv0mk9gi", size=50, user="ubuntu"},
      "kuber-worker02.netology.yc" = {name="kuber-worker02", zone = "ru-central1-b", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-b.id, image_id="fd8snjpoq85qqv0mk9gi", size=50, user="ubuntu"},
      "jenkins-master.netology.yc" = {name="jenkins-master", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8sni054daiudopdnfe", size=50, user="cloud-user"},
      "jenkins-agent.netology.yc"  = {name="jenkins-agent", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8sni054daiudopdnfe", size=50, user="cloud-user"}
    }
    stage = {
      "kuber-master01.netology.yc" = {name="kuber-master01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8snjpoq85qqv0mk9gi", size=50, user="ubuntu"},
      "kuber-worker01.netology.yc" = {name="kuber-worker01", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8snjpoq85qqv0mk9gi", size=50, user="ubuntu"},
      "kuber-worker02.netology.yc" = {name="kuber-worker02", zone = "ru-central1-b", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-b.id, image_id="fd8snjpoq85qqv0mk9gi", size=50, user="ubuntu"},
      "jenkins-master.netology.yc" = {name="jenkins-master", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8sni054daiudopdnfe", size=50, user="cloud-user"},
      "jenkins-agent.netology.yc"  = {name="jenkins-agent", zone = "ru-central1-a", cores = 2, memory = 4, subnet_id = yandex_vpc_subnet.subnet-public-a.id, image_id="fd8sni054daiudopdnfe", size=50, user="cloud-user"}
    }
  }
}

# fd8snjpoq85qqv0mk9gi  ubuntu 20.04 tls
# fd8sni054daiudopdnfe  centos upstream 8
