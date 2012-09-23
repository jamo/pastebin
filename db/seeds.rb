# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:username => 'admin', :password => 'admin',:password_confirmation => 'admin', :admin => true, :email =>'admin@isotalo.fi', :email_confirmation => 'admin@isotalo.fi',:first_name =>'admin',:last_name=>'admin').save!