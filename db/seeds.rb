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

@snippet = Snippet.create(name: 'About', pinned: true, content: 'Sometext', snippet_type: 'about', creator_id: @user.id, updater_id: @user.id)
Bucket.create(name: 'Explorer Pictures', attachable_id: @snippet.id, attachable_type: 'Snippet', :name_fixed => true, creator_id: @user.id, updater_id: @user.id)

ItemClassification.create(name: 'Object', description: 'everything is an object')
