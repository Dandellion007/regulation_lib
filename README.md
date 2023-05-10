### Запуск проекта
```
docker-compose build
docker-compose up
docker exec regulation_lib_app bundle exec rake db:setup db:migrate 
```
про `db:setup` https://stackoverflow.com/questions/10301794/difference-between-rake-dbmigrate-dbreset-and-dbschemaload

Зайти в контейнер для выполнения команд
```
docker exec -it regulation_lib_app bash 
```