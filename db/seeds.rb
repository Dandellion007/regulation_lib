# frozen_string_literal: true

User.new(
  email: 'admin',
  password: 'qwerty',
  full_name: 'Администратор',
  company: 'Компания администратора',
  company_department: 'Отдел компании',
  company_activity: 'учебная деятельность',
  is_admin: true
).save!(validate: false)

User.new(
  email: 'test_user',
  password: 'test',
  full_name: 'Тестовый пользователь',
  company: 'Тестовая компания',
  company_department: 'Отдел тестиования',
  company_activity: 'учебная деятельность'
).save!(validate: false)
