 

## Упражнение 00 — Аудит входящих INSERT

| Упражнение 00: Аудит входящих INSERT |                  |
| ------------------------------------ | ---------------- |
| Директория для сдачи                 | ex00             |
| Файлы для сдачи                      | `day09_ex00.sql` |
| **Разрешено**                        |                  |
| Язык                                 | SQL, DDL, DML    |

Мы хотим быть сильнее в работе с данными и не терять ни одного события изменения. Давайте реализуем функцию аудита для входящих `INSERT`.  

Создайте таблицу **person_audit** с той же структурой, что и таблица **person**, но с дополнительными изменениями. Смотри описание в таблице ниже:

| Колонка    | Тип                      | Описание                                                                                                                                         |
| ---------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| created    | timestamp with time zone | время создания события. По умолчанию = `current_timestamp`. NOT NULL                                                                             |
| type_event | char(1)                  | значения: I (insert), D (delete), U (update). По умолчанию = ‘I’. NOT NULL. Добавить check constraint `ch_type_event` на значения ‘I’, ‘U’, ‘D’. |
| row_id     | bigint                   | копия person.id. NOT NULL                                                                                                                        |
| name       | varchar                  | копия person.name (без ограничений)                                                                                                              |
| age        | integer                  | копия person.age (без ограничений)                                                                                                               |
| gender     | varchar                  | копия person.gender (без ограничений)                                                                                                            |
| address    | varchar                  | копия person.address (без ограничений)                                                                                                           |

👉 Реализуй **триггерную функцию** `fnc_trg_person_insert_audit`, которая должна ловить `INSERT`-трафик и копировать новые строки данных в `person_audit`.

💡 Напоминание: PostgreSQL-триггер = **2 объекта**:  

1. Trigger Function  
2. Сам Trigger  

Создай триггер **trg_person_insert_audit**:  

- `FOR EACH ROW`;  
- `AFTER INSERT`;  
- вызывает `fnc_trg_person_insert_audit`.  

Проверь через `INSERT`:  

```sql
INSERT INTO person(id, name, age, gender, address)
VALUES (10,'Damir', 22, 'male', 'Irkutsk');
```

---

## Упражнение 01 — Аудит входящих UPDATE

| Упражнение 01: Аудит входящих UPDATE |                  |
| ------------------------------------ | ---------------- |
| Директория для сдачи                 | ex01             |
| Файлы для сдачи                      | `day09_ex01.sql` |
| **Разрешено**                        |                  |
| Язык                                 | SQL, DDL, DML    |

Теперь продолжаем аудит для `UPDATE`. Создайте триггер `trg_person_update_audit` и триггерную функцию `fnc_trg_person_update_audit`, которые будут сохранять **старые значения (OLD)** всех колонок при изменениях.

Проверь через:  

```sql
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
```

---

## Упражнение 02 — Аудит входящих DELETE

| Упражнение 02: Аудит входящих DELETE |                  |
| ------------------------------------ | ---------------- |
| Директория для сдачи                 | ex02             |
| Файлы для сдачи                      | `day09_ex02.sql` |
| **Разрешено**                        |                  |
| Язык                                 | SQL, DDL, DML    |

Дальше обрабатываем `DELETE`. То есть — копируем **старые значения (OLD)** удаляемых строк. Создайте:  

- триггер `trg_person_delete_audit`  
- функцию `fnc_trg_person_delete_audit`  

Проверь через:  

```sql
DELETE FROM person WHERE id = 10;
```

---

## Упражнение 03 — Универсальный аудит

| Упражнение 03: Универсальный аудит |                  |
| ---------------------------------- | ---------------- |
| Директория для сдачи               | ex03             |
| Файлы для сдачи                    | `day09_ex03.sql` |
| **Разрешено**                      | SQL, DDL, DML    |

Сейчас у нас **три разных триггера** на одну таблицу. Давайте объединим логику в один:  

- триггер **trg_person_audit**  
- функция **fnc_trg_person_audit**  

Одна функция должна обрабатывать все события `INSERT`, `UPDATE`, `DELETE`. Внутри кода сделайте отдельные блоки `IF-ELSE` для каждого события.  

Дополнительно:  

- удалить старые 3 триггера,  
- удалить старые 3 функции,  
- очистить таблицу `person_audit` (`TRUNCATE` или `DELETE`).  

Проверьте полным набором:  

```sql
INSERT INTO person(id, name, age, gender, address)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
```

---

## Упражнение 04 — Представление VS Функция

| Упражнение 04 |                  |
| ------------- | ---------------- |
| Директория    | ex04             |
| Файлы         | `day09_ex04.sql` |
| **Разрешено** | SQL, DDL, DML    |

Ранее мы делали два **VIEW** для разбиения таблицы `person` по полу. Теперь сделаем SQL-функции:  

- `fnc_persons_female()` — возвращает женщин  
- `fnc_persons_male()` — возвращает мужчин  

Вызов:  

```sql
SELECT * FROM fnc_persons_male();
SELECT * FROM fnc_persons_female();
```

---

## Упражнение 05 — Параметризованная функция базы

| Упражнение 05 |                  |
| ------------- | ---------------- |
| Директория    | ex05             |
| Файлы         | `day09_ex05.sql` |
| **Разрешено** | SQL, DDL, DML    |

Функции из задания 04 слишком частные. Удалите их и сделайте **одну функцию** `fnc_persons(pgender text DEFAULT 'female')`.  

Вызов:  

```sql
SELECT * FROM fnc_persons(pgender := 'male');
SELECT * FROM fnc_persons();
```

---

## Упражнение 06 — Функция-обертка

| Упражнение 06 |                  |
| ------------- | ---------------- |
| Директория    | ex06             |
| Файлы         | `day09_ex06.sql` |
| **Разрешено** | SQL, DDL, DML    |

Теперь познакомимся с **PL/pgSQL**.  

Создайте функцию `fnc_person_visits_and_eats_on_date(pperson text DEFAULT 'Dmitriy', pprice int DEFAULT 500, pdate date DEFAULT '2022-01-08')`.  

Она должна:  

- выводить имена пиццерий,  
- которые посетил `pperson`,  
- и где можно было купить пиццу дешевле `pprice`,  
- именно в дату `pdate`.  

Вызов:  

```sql
SELECT * FROM fnc_person_visits_and_eats_on_date(pprice := 800);
SELECT * FROM fnc_person_visits_and_eats_on_date(pperson := 'Anna', pprice := 1300, pdate := '2022-01-01');
```

---

## Упражнение 07 — Поиск минимума

| Упражнение 07 |                  |
| ------------- | ---------------- |
| Директория    | ex07             |
| Файлы         | `day09_ex07.sql` |
| **Разрешено** | SQL, DDL, DML    |

Напишите SQL- или PL/pgSQL-функцию `func_minimum(arr NUMERIC[])`, которая принимает массив чисел и возвращает минимальное значение.  

Вызов:  

```sql
SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
```

---

## Упражнение 08 — Алгоритм Фибоначчи в функции

| Упражнение 08 |                  |
| ------------- | ---------------- |
| Директория    | ex08             |
| Файлы         | `day09_ex08.sql` |
| **Разрешено** | SQL, DDL, DML    |

Напишите SQL- или PL/pgSQL-функцию `fnc_fibonacci(pstop int DEFAULT 10)`, которая возвращает **таблицу чисел Фибоначчи, меньших чем `pstop`**.  

Вызов:  

```sql
SELECT * FROM fnc_fibonacci(100);
SELECT * FROM fnc_fibonacci();
```
