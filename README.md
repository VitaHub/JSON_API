## JSON API for blog

#### 1. Поставить оценку посту
route: *api/v1/marks*, принимает параметры: post_id, value  
Возвращает новый средний рейтинг хэшем.  
Для корректного отрабатывания действия при конкурентных запросах использовал Mutex.  
Без использования колбэка в модели не обошлось - после создания оценки обновляется рейтинг поста.  
[Controller](app/controllers/api/v1/marks_controller.rb)

#### 2. Получить топ N постов по среднему рейтингу
route: *api/v1/posts*, принимает параметры: limit  
Возвращает массив объектов с заголовками и содержанием. 
Для быстрой обработки запроса добавил в таблицу поста колонку рейтинга.  
[Controller](app/controllers/api/v1/posts_controller.rb)

#### 3. Получить список айпи, с которых постило несколько авторов
route: *api/v1/addresses*  
Возвращает массив объектов с полями: ip и users(массив логинов пользователей)  
Для быстрой обработки запроса выделил отдельную таблицу модель *Address* с одним столбцом *ip* так, что:

```ruby
class Address < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :posts
end

class User < ApplicationRecord
  has_many :posts
  has_and_belongs_to_many :addresses
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :marks
  belongs_to :address
end
```
[Controller](app/controllers/api/v1/addresses_controller.rb)


[Выполненное задание на знание SQL](sql_task.md)
