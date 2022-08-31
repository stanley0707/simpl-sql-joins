-- Задание 2
-- Вывести в таблице
--  * имя сотрудника
--  * грейд сотрудника
--  * зарплата сотрудника
--  * количество департаментов, в которых числится сотрудник
--
--  1. Отсортировать по (Имени сотрудника, количеству департаментов по убыванию)
--  2. + Сгруппировать по грейду, вывести:
--   * Количество сотрудником с этим грейдом
--   * Количество сотрудников c этим грейдом, которые числятся более чем в одном департаменте
--   * среднюю ЗП сотрудников с этим грейдом
--
-- Решение ниже на диалекте SQLite


-- выборка все сотрудников с типом грейда, размером грейда и кол-вом департаментов
SELECT
    user.name as user_name,
    user.grade as user_grade,
    salary.salary as user_salary,
    count(department.id) as department_user_count

    FROM user
        JOIN mtm ON mtm.department_id = department.id AND mtm.user_id = user.id
        JOIN department ON mtm.department_id = department.id
        INNER JOIN salary ON salary.user_id = user.id
    GROUP BY user.id
    ORDER BY user.name, department_user_count DESC;


-- выборка всех типов грейдов с агрегацией сотрудников и avg значением зарплаты
SELECT
    user.grade as grade,
    count(user.id) as salary_user_count,

    case when count(department.id) > 1
            then 0
        else count(department.id)
    end AS more_than_one_department_user_count,

    avg(salary.salary) avg_salary

    FROM salary
        JOIN user ON salary.user_id = user.id
        JOIN mtm ON mtm.department_id = department.id AND mtm.user_id = user.id
        JOIN department ON mtm.department_id = department.id
    GROUP BY salary.salary;