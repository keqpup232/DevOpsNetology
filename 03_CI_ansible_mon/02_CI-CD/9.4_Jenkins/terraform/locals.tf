locals {
  web_instance_each_map = {
    prod = {
      "jenkins-master.netology.yc" = "node-jenkins-master",
      "jenkins-agent.netology.yc" = "node-jenkins-agent"
    }
  }
}