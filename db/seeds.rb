# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_entity = Entity.create name: 'user'

Validation.create field: 'email', rule: '^[\w\.+-]+@([\w]+\.)+[a-zA-Z]+$', message: 'invalid', entity: user_entity
Validation.create field: 'email', rule: '\S+', message: 'can\'t be blank', entity: user_entity
Validation.create field: 'name', rule: '\S+', message: 'can\'t be blank', entity: user_entity

User.create name: 'admin', email: 'admin@admin.ru', password: 'admin', password_confirmation: 'admin', confirmed_at: DateTime.now