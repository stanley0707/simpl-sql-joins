-- Задание 1
-- Вывести в таблице:
--  * имя департамента
--  * количество сотрудников с ЗП (что имеется ввиду, сотрудников без ЗП не может быть?)
--  * количество сотрудников с грейдом "А"
--  * количество сотрудников с другими грейдами
--  * максимальную ЗП по департаменту
--  1. + Отсортировать по (Имени департамента, размеру ЗП: двойнай сортировка)
--  2. + Для департаментов, в которых 0 сотрудников. (что именно для департаментов без сотрудников?)
--
-- Решение ниже на диалекте SQLite


-- выборка департаментов с агрегацией общего кол-ва сотрудников, кол-ва сотрудников по типу грейда,
-- и отображением максимальной ЗП по департаменту
SELECT
    department.name AS department_name,
    count(mtm.user_id) AS all_users_count,
    count(case when user.grade = 'A' then 0 end) AS grade_A,
    count(case when user.grade = 'B' then 0 end) AS grade_B,
    count(case when user.grade = 'C' then 0 end) AS grade_C,
    count(case when user.grade = 'D' then 0 end) AS grade_D,

    max(salary.salary) AS max_grade_department_size

    FROM department
        JOIN mtm ON mtm.department_id = department.id AND mtm.user_id = user.id
        JOIN user ON mtm.user_id = user.id
        INNER JOIN salary ON salary.user_id = user.id

    GROUP BY department.id
    ORDER BY department.name DESC, user.grade ASC;
