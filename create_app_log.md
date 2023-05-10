# Application regulation_lib
### Cоздание Rails приложения с Postgres
https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-18-04

### Создание приложение с БД PostgreSql
```
rails new regulation_lib -d=postgresql
```

### PostgreSql user
name: regulation_lib  
pass: r2mMnKA6ch

Create Linux user
```
sudo adduser regulation_lib
sudo usermod -aG sudo regulation_lib
```
Create PostgreSql user 
```
sudo su - postgres -c 'createuser -s regulation_lib -P'
```

### Исправление ошибки с невозможностью подключения к БД
https://stackoverflow.com/questions/18664074/getting-error-peer-authentication-failed-for-user-postgres-when-trying-to-ge


### Контейнеризация Rails приложений
https://www.digitalocean.com/community/tutorials/containerizing-a-ruby-on-rails-application-for-development-with-docker-compose#step-5-testing-the-application

### Установка Docker и Docker-Compose
https://github.com/abak-press/crm_tulip/blob/072fafc29c8e45629808a453cb9779b88424da57/docs/frontend/docker/README.md


### Настройки снипетов и горячих клавиш для VS Code
https://code.visualstudio.com/docs/editor/userdefinedsnippets#_creating-your-own-snippets
https://code.visualstudio.com/docs/editor/userdefinedsnippets
~/.config/Code/User/snippets/user_snippets.code-snippets
~/.config/Code/User/keybindings.json

### Про Docker
https://1cloud.ru/blog/docker_start

### Про docker-compose
https://1cloud.ru/blog/docker-compose

[5 приемов оптимизации сборки Docker-образов](https://1cloud.ru/help/docker/5_docker_tricks)  
[Работа с Dockerfile](https://1cloud.ru/help/docker/dockerfile_work)  
[Команды Docker для работы с образами](https://1cloud.ru/help/docker/docker_image_work)  
[Команды Docker по работе с контейнерами](https://1cloud.ru/help/docker/docker_container)  

Создать контейнер из образа и войти в нем в консоль
```
docker run -it <image_name> bash
```
Создать образ на основе Dockerfile, который находится в path
Если не указывать тег, то по усолчанию указывается `latest`
И во всех командах, где используется название образа, тоже по умолчанию добавлется `latest`
При указании другого тега в build далее везде(?) нужно будет обращаться к образу  `conteiner_name:teg_name`
```
docker build -t <conteiner_name>:<teg_name> <path>
```
Вывести все запущенные контейнеры в виде таблиц со столбиками `Names, ID, Image`
```
docker ps -a --format "table {{.Names}}\t{{.ID}}\t{{.Image}}"
```

Когда есть данные в виде таблицы можно вывести одну из колонок через `awk`
```
echo 'one two three four' | awk '{print $4}'
```


### Docker docs
https://docs.docker.com/engine/reference/run/


### Rails original Guides
https://guides.rubyonrails.org/


### PostgreSQL docker-image Guide
https://hub.docker.com/_/postgres


### Routes в Rails приложении
В самом веб приложении
http://localhost:3000/rails/info/routes
Через командную строку
```rails routes```