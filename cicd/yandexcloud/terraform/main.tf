terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token = "y0_AgAAAABp6VSSAATuwQAAAADjtHcgAvMF4RlLTCqwxMNuINnCiqXitX4"
  folder_id = "b1gq4eur39aa21ko5g01"
  zone = "ru-central1-a"
}
