


















# Terraform state
# terraform state show [id] - показать состояние выбранного ресурса
# terraform state list - показывает все ресурсы, которые есть в remote state
# terraform state pull - читает весь remote state и выводит это на жкран

# DANGER - ОПАСНЫЕ КОМАНДЫ
# terraform state rm [id] - удалить ресурс по его ид
# terraform state mv [id] - переместить ресурс без удаления или переименовать. извлечь remote state из фала состояния в локальный файл
# terraform state mv -state-out="terraform.tfstate" aws_eip.myip-prod aws_eip.myip-prod
# terraform state push - overwrite state. перезаписывает  

# как сделать рефакторинг?
# 1. перекинуть файлы по директориям
# 2. сделать terraform state mv
# если провтыкали ресурс и отправили уже стейт в бакет, то terraform state pull > terraform.tfstate и продолжаем pull
# даже если провтыкали всё вместе с бекапами, то terraform import
