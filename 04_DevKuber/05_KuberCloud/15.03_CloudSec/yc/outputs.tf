output "CAT_image" {
  value = "https://storage.yandexcloud.net/${yandex_storage_bucket.bucket.bucket}/${yandex_storage_object.cat-picture.key}"
}

output "load_balancer_ip" {
  value = yandex_lb_network_load_balancer.load_balancer.listener.*.external_address_spec[*].*.address
}
