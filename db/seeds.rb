# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.delete_all
Role.delete_all
@user = User.create(email: 't.schmidt@rubidat.de', username: 'toboter', password: 'topsecret', password_confirmation: 'topsecret')
Role.create(user_id: @user.id, role: 'superuser')