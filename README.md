### Endpoints
Токен: `/user_token`

Параметры: `'{"auth":{"email":"login@mail.com","password":"secret"}}'`

Отправить сообщение: `/message`
    
Парамметры:
    
    { 'body':'Some text',
      'deliver_in':'time', #опционально
      'destinations_attributes':[{ 'messenger':'telegram',
                                   'nickname':'jack' }]}
                                                       
Хедер: `Authorization: Bearer Токен`

### Комментарий

Адаптор для очереди sidekiq, был выбран т.к он корректно работает с activejob.

Создание user не реализовано. Можно использовать rake db:seed.

[Ссылка на развернутое приложение](http://18.195.59.194)

### Deploy

На сервере должно быть установлено:

    nginx, rvm, ruby, rails, bundler, postgresql, redis

Должен быть создать пользователя в PG.
Создать и заполнить .env (use example_env) по адресу /home/username/apps/appname/shared:

    PROD_SECRET=
    DEV_SECRET=
    TEST_SECRET=
    
    DB_PASSWORD=
    DB_USER=
    DB_NAME=
    
Необходимо заполнить config/deploy.rb:
    
    server, port, repo_url, application, user
    
Заменить значения username, appname в config/example_nginx.conf

Слить изменения на репозиторий.

Задеплоить командой:

    cap production deploy:initial
    
Скопировать или сделать ярлык config/example_nginx.conf в /etc/nginx/sites-enabled/ удалив при этом default.

    