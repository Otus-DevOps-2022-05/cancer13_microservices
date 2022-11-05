# cancer13_microservices
cancer13 microservices repository

# HW 12 docker-2
Выполнено основное задание.

В задании указано назвать папку `dockermonolith`, в тестах ищится папка `docker-monolith`

docker-machine более не входит в состав docker desktop.
Поставил docker-machine через brew (brew install docker-machin)

\
Контейнер собранный по Dockerfile предложенного в ДЗ не стартует.
```
! Unable to load application: NameError: uninitialized constant Mongo::Client
/reddit/app.rb:11:in `block in <top (required)>': uninitialized constant Mongo::Client (NameError)
        from /var/lib/gems/2.5.0/gems/sinatra-2.0.8.1/lib/sinatra/base.rb:1427:in `configure'
        from /var/lib/gems/2.5.0/gems/sinatra-2.0.8.1/lib/sinatra/base.rb:1919:in `block (2 levels) in delegate'
        from /reddit/app.rb:10:in `<top (required)>'
        from /usr/lib/ruby/2.5.0/rubygems/core_ext/kernel_require.rb:59:in `require'
        from /usr/lib/ruby/2.5.0/rubygems/core_ext/kernel_require.rb:59:in `require'
        from config.ru:1:in `block in <main>'
        from /var/lib/gems/2.5.0/gems/rack-2.2.4/lib/rack/builder.rb:116:in `eval'
        from /var/lib/gems/2.5.0/gems/rack-2.2.4/lib/rack/builder.rb:116:in `new_from_string'
        from /var/lib/gems/2.5.0/gems/rack-2.2.4/lib/rack/builder.rb:105:in `load_file'
        from /var/lib/gems/2.5.0/gems/rack-2.2.4/lib/rack/builder.rb:66:in `parse_file'
        from /var/lib/gems/2.5.0/gems/puma-5.6.4/lib/puma/configuration.rb:348:in `load_rackup'
        from /var/lib/gems/2.5.0/gems/puma-5.6.4/lib/puma/configuration.rb:270:in `app'
        from /var/lib/gems/2.5.0/gems/puma-5.6.4/lib/puma/runner.rb:150:in `load_and_bind'
        from /var/lib/gems/2.5.0/gems/puma-5.6.4/lib/puma/single.rb:44:in `run'
        from /var/lib/gems/2.5.0/gems/puma-5.6.4/lib/puma/launcher.rb:182:in `run'
        from /var/lib/gems/2.5.0/gems/puma-5.6.4/lib/puma/cli.rb:81:in `run'
        from /var/lib/gems/2.5.0/gems/puma-5.6.4/bin/puma:10:in `<top (required)>'
        from /usr/local/bin/puma:23:in `load'
        from /usr/local/bin/puma:23:in `<main>'
```
Лечение -> Необходимо добавить в `Dockerfile`
```
RUN gem install bundler
RUN gem install mongo
```
Возможно надо использовать ubuntu 16 как это было в предыдущих ДЗ
________________
# HW 13 docker-3
- [x] Выполнено основное задание

\
`ЭТО НАДО ПОФИКСИТЬ`\
По умолчанию контейнер с post_app.py не стартует, определены версии не всех зависимостей, что приводит к ошибке.\
Путём гугляжа, проб и ошибок выявлено, что в `src/post-py/requirements.txt` модуль фласк должен быть версии `flask==0.12.5`  (по умолчанию указана версия 0.12.3)\
\
\
команды используемые в ДЗ
```
docker build -t cancer13/post:1.0 ./post-py
docker build -t cancer13/comment:1.0 ./comment
docker build -t cancer13/ui:1.0 ./ui
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post cancer13/post:1.0
docker run -d --network=reddit --network-alias=comment cancer13/comment:1.0
docker run -d --network=reddit -p 9292:9292 cancer13/ui:2.0
```
________________
# HW 14 docker-4
- [x] Выполнено основное задание

Имя проекта для compose задаётся через переменную COMPOSE_PROJECT_NAME в .env
___
# HW 16 monitoring-1
- [x] Выполнено основное задание
- [x] * Добавьте в Prometheus мониторинг MongoDB

Dockerhub https://hub.docker.com/u/cancer13
# HW17 logging-1
- [x] Сделано основное задание
Использован fluentd свежих версий (на версии 0.12 не хотел подключаться к elasticsearch)
Использован elastic стек версии 7.16.3

- [x] Сделано задание со *
pattern ^service=%{NOTSPACE:service} \| event=%{NOTSPACE:event} (\| path=%{PATH:path} )?\| request_id=%{NOTSPACE:request_id}( \| remote_addr=%{IP:remote_addr} \| method=%{SPACE}%{WORD:method} \| response_status=%{INT:response_status})?( \| message='%{GREEDYDATA:message}')?$

# HW18 kubernetes-1
Выполнено основное задание.
Выполнено задание со * - развёртка кубера через терраформ и ансибл
# HW19 kubernetes-3
Выполнено основное задание

k8s version 1.20 ya-cloud

Добавил конфигурацию терраформ для поднятия кластера в ya-cloud

# HW20 kubernetes-2
На сайте OTUS из-за перетрубаций с лекциями (то кто-то болел, то ещё что-то, да и вообще живём в интересное время) произошла путаница с лекциями и домашними заданиями (забавно что мне пришлось искать самому инфу и решать траблы в разрыве между kubernetes-1 и kubernetes-3, надо было в слаке поднять этот вопрос)

Развил тему с встраиванием helm'ов в terraform (дашбоардс и ингресс).

- [x] Выполнено основное задание
- [x] Выполнено задание со звёздочкой

# HW21 kubernetes-4
- [x] Выполнено основное задание - было не просто)
- [x] Выполнил задание со * (в main после релиза трегирится пайп деплоя)
      `"curl -X POST --fail -F token=$TOKEN -F ref=main https://gitlab.$gitlab_host/api/v4/projects/2/trigger/pipeline"`


- Использовал:
  - Helm v3.10.1 (в методичке вторая версия)
    - На лекции подсветили что helm 2 устарел и лучше его не использовать
  - k8s 1.22
  - Сервис sslip.io указывал как host в ingress (пока без автоматизации)
  - Helm chart GitLab последней версии
  - Самописный chart с mongodb v3.2 (не нашёл чарт под версию 3)


- Заметки:
  - Для работы с helm репозиторий gitlab не доступен без VPN
  - GitLab стартует только с указанием `<EXT_IP-адресс_ingress-контроллера>.sslip.io` в `global.hosts.domain`
  - В GitLab при добавлении переменных по умолчанию включен Protect variable - что не позволяет использовать переменные на "не защищённых" ветка репозитория...
  - Докер жалуется на не безопасность использования параметра `--password`, останавливает работу, рекомендует использовать `--password-stdin`, переделал строку с авторизацией в докер:
    - echo "$CI_REGISTRY_PASSWORD" | docker login -u "$CI_REGISTRY_USER" --password-stdin
  - Вместо пароля от `dockerhub` использовал токен (хотя сильно разницы не вижу, разве что токинами можно управлять)
  - Люди решили что называть ветку `master` это расизм, и теперь везде надо использовать `main`
  - Обязательно надо создать роль (`clusterrolebinding`) для пользователя которого использует github при раскатке
    - kubectl create clusterrolebinding gitlab-admin --clusterrole=cluster-admin --serviceaccount=gitlab:default
  - Так же желательно при раскатке gitlab дать уз раннера кастомное имя (хотя это уже вопросы безопасности)
