# Тестовое 

Перед началом работы создайте folder, service acсount и получите ключ или импортируйте через env. В provider.tf в блоке 

    provider "yandex" {
    zone = var.az_zone
    service_account_key_file="key.json"
    folder_id = "b1gc7ib0c849c2havu62"
    }

поменяйте значения  folder_id и service_account_key_file на свои

## Заданиe. Часть 1.

    Отдельный terraform план для развертывания подсети. CIDR и имя подсети должны быть оформлены как входные параметры, остальные параметры можно по усмотрению задать статически.
    
Файл network.tf, vars  terraform.tfvars: cidr-int - cidr внутренней подсети, cidr-ext - cidr внешней подсети,  internal_subnet - имя внутренней подсети, external_subnet - имя внешней подсети

	Отдельный terraform план для развертывания виртуальной машины. Имя ВМ, ОС должны быть оформлены как входные параметры, ВМ должна быть подключена к подсети, созданной предыдущим terraform планом, остальные параметры можно по усмотрению задать статически.

Файл instance_one.tf , vars  terraform.tfvars: instance_one_name - имя,  instance_one_os - версия образа

    Отдельный terraform план для развертывания виртуальной машины, количество дисков должно быть указано как входные параметры, ВМ должна быть подключена к подсети, созданной предыдущим terraform планом, остальные параметры можно по усмотрению задать статически.

Файл instance_two.tf , vars  terraform.tfvars: instance_two_disk_number - количество дисков

    На виртуальной машине должен быть поднять любой по желанию веб сервер.

Поднят nginx через cloud-init в cloudinit.yml

    Результатом всего процесс должен быть получен url на страницу заглушку развернутого веб сервера.

Реализован в output.tf, выывод вида

external_url_one = "http://<<ip>>"

external_url_two = "http://<<ip>>"

    Теоретическое задание, подтвердить или опровергнуть, что средствами terraform, можно редактировать уже существующие ранее развернутые ВМ, подтвердить документацией

Можно, например, командой "terraform import yandex_compute_instance.instance.<<instance_id>>". После импорта надо добавить ресурс в .tf файл. Для удобства имеет смысл проверить через "terraform plan" значение управляемых ресурсов и подогнать под них если что-то забыли. Документация здесь https://developer.hashicorp.com/terraform/cli/commands/import

## Заданиe. Часть 2.

