# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Group.create! [
  {:name => "guest"},
  {:name => "user" },
  {:name => "admin"}
]
guest_pass = SecureRandom.hex(5)
User.create! :name => "guest", :password => guest_pass, :password_confirmation => guest_pass, :email => "guest@localhost.com", :avatar => "" do |u|
  u.id = 0
  u.groups << Group.find(1)
end
User.create! :name => "admin", :password => "admin", :password_confirmation => "admin", :email => "system@localhost.com", :avatar => "/admin.png" do |u|
  u.groups << Group.find(1)
  u.groups << Group.find(2)
  u.groups << Group.find(3)
end
