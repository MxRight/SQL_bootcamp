

## Упражнение 00 — Давайте создадим индексы для каждого внешнего ключа

| Упражнение 00: Давайте создадим индексы для каждого внешнего ключа |                  |
| ------------------------------------------------------------------ | ---------------- |
| Директория для сдачи                                               | ex00             |
| Файлы для сдачи                                                    | `day05_ex00.sql` |
| **Разрешено**                                                      |                  |
| Язык                                                               | ANSI SQL         |

Создайте простой BTree-индекс для каждого внешнего ключа в нашей базе данных.  

Шаблон наименования должен соответствовать правилу:  
**`idx_{table_name}_{column_name}`**

Например, имя BTree-индекса для колонки `pizzeria_id` в таблице `menu` должно быть **`idx_menu_pizzeria_id`**.  

---

## Глава V

## Упражнение 01 — Как доказать, что индекс работает?

| Упражнение 01: Как доказать, что индекс работает? |                  |
| ------------------------------------------------- | ---------------- |
| Директория для сдачи                              | ex01             |
| Файлы для сдачи                                   | `day05_ex01.sql` |
| **Разрешено**                                     |                  |
| Язык                                              | ANSI SQL         |

Перед тем как продолжить, напишите SQL-запрос, который возвращает пиццы и соответствующие названия пиццерий.  
Результат должен быть примерно таким (сортировка не требуется):  

| pizza_name   | pizzeria_name |
| ------------ | ------------- |
| cheese pizza | Pizza Hut     |
| ...          | ...           |

Теперь докажем, что индекс заработал для вашего SQL-запроса.  

Пример доказательства — это вывод команды **`EXPLAIN ANALYZE`**.  

Образец вывода:  

```
...
->  Index Scan using idx_menu_pizzeria_id on menu m  (...)
...
```

**Подсказка**: подумайте, почему ваши индексы не работают напрямую, и что нужно сделать, чтобы их включить. 😉  

---

## Глава VI

## Упражнение 02 — Формула в индексе. Это нормально?

| Упражнение 02: Формула в индексе. Это нормально? |                  |
| ------------------------------------------------ | ---------------- |
| Директория для сдачи                             | ex02             |
| Файлы для сдачи                                  | `day05_ex02.sql` |
| **Разрешено**                                    |                  |
| Язык                                             | ANSI SQL         |

Создайте функциональный BTree-индекс `idx_person_name` на колонку `name` в таблице `person`.  
Индекс должен хранить имена людей **в верхнем регистре**.  

Напишите и приложите любой SQL с доказательством (`EXPLAIN ANALYZE`), что индекс `idx_person_name` действительно работает.  

---

## Глава VII

## Упражнение 03 — Мультиколоночный индекс для наших целей

| Упражнение 03: Мультиколоночный индекс для наших целей |                  |
| ------------------------------------------------------ | ---------------- |
| Директория для сдачи                                   | ex03             |
| Файлы для сдачи                                        | `day05_ex03.sql` |
| **Разрешено**                                          |                  |
| Язык                                                   | ANSI SQL         |

Создайте многоколоночный BTree-индекс `idx_person_order_multi` для следующего SQL-запроса:

```sql
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;
```

Команда `EXPLAIN ANALYZE` должна вернуть примерно такой паттерн (обратите внимание: **Index Only Scan**!):

```
Index Only Scan using idx_person_order_multi on person_order ...
```

Приложите любой SQL с доказательством (`EXPLAIN ANALYZE`), что **`idx_person_order_multi`** работает.  

---

## Глава VIII

## Упражнение 04 — Уникальность для данных

| Упражнение 04: Уникальность для данных |                  |
| -------------------------------------- | ---------------- |
| Директория для сдачи                   | ex04             |
| Файлы для сдачи                        | `day05_ex04.sql` |
| **Разрешено**                          |                  |
| Язык                                   | ANSI SQL         |

Создайте уникальный BTree-индекс `idx_menu_unique` на таблицу `menu` для колонок **`pizzeria_id`** и **`pizza_name`**.  

Напишите и приложите любой SQL с доказательством (`EXPLAIN ANALYZE`), что индекс `idx_menu_unique` работает.  

---

## Глава IX

## Упражнение 05 — Частичная уникальность для данных

| Упражнение 05: Частичная уникальность для данных |                  |
| ------------------------------------------------ | ---------------- |
| Директория для сдачи                             | ex05             |
| Файлы для сдачи                                  | `day05_ex05.sql` |
| **Разрешено**                                    |                  |
| Язык                                             | ANSI SQL         |

Создайте **частично уникальный** BTree-индекс `idx_person_order_order_date` на таблицу `person_order` по колонкам `person_id` и `menu_id`, с учетом частичной уникальности по колонке `order_date` для даты `'2022-01-01'`.  

Команда `EXPLAIN ANALYZE` должна вернуть примерно такой паттерн:

```
Index Only Scan using idx_person_order_order_date on person_order …
```

---

## Глава X

## Упражнение 06 — Улучшим производительность

| Упражнение 06: Улучшим производительность |                  |
| ----------------------------------------- | ---------------- |
| Директория для сдачи                      | ex06             |
| Файлы для сдачи                           | `day05_ex06.sql` |
| **Разрешено**                             |                  |
| Язык                                      | ANSI SQL         |

Рассмотрим следующий SQL **с технической стороны** (игнорируем его логику):

```sql
SELECT
    m.pizza_name AS pizza_name,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
FROM  menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1,2;
```

Создайте новый BTree-индекс `idx_1`, который должен улучшить метрику **Execution Time** для этого SQL.  

Предоставьте доказательство (`EXPLAIN ANALYZE`), что SQL действительно стал работать быстрее.  

**Подсказка**: это упражнение похоже на «поиск грубой силой» подходящего cover-индекса. Поэтому перед новым тестом удаляйте `idx_1`.  

---

Пример моего улучшения:

**До**:

```
Sort  (cost=26.08..26.13 rows=19 width=53) (actual time=0.247..0.254 rows=19 loops=1)
"  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
Sort Method: quicksort  Memory: 26kB
->  WindowAgg  (cost=25.30..25.68 rows=19 width=53) (actual time=0.110..0.182 rows=19 loops=1)
        ->  Sort  (cost=25.30..25.35 rows=19 width=21) (actual time=0.088..0.096 rows=19 loops=1)
            Sort Key: pz.rating
            Sort Method: quicksort  Memory: 26kB
            ->  Merge Join  (cost=0.27..24.90 rows=19 width=21) (actual time=0.026..0.060 rows=19 loops=1)
                    Merge Cond: (m.pizzeria_id = pz.id)
                    ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.013..0.029 rows=19 loops=1)
                        Heap Fetches: 19
                    ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..12.22 rows=6 width=15) (actual time=0.005..0.008 rows=6 loops=1)
Planning Time: 0.711 ms
Execution Time: 0.338 ms
```

**После**:

```
Sort  (cost=26.28..26.33 rows=19 width=53) (actual time=0.144..0.148 rows=19 loops=1)
"  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
Sort Method: quicksort  Memory: 26kB
->  WindowAgg  (cost=0.27..25.88 rows=19 width=53) (actual time=0.049..0.107 rows=19 loops=1)
        ->  Nested Loop  (cost=0.27..25.54 rows=19 width=21) (actual time=0.022..0.058 rows=19 loops=1)
            ->  Index Scan using idx_1 on …
            ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..2.19 rows=3 width=22) (actual time=0.004..0.005 rows=3 loops=6)
…
Planning Time: 0.338 ms
Execution Time: 0.203 ms
```
