# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

org1 = Organization.create(name: 'The White House', web_page: 'http://www.whitehouse.gov')
city = Location.create(city: 'New York', admin_level1: 'New York', country: 'US', point: 0)
manager1 = People.create(name: 'Barack Obama', organization: org1, position: 'The President', department: 'The Executive Branch', email_address: 'barack.obama@whitehouse.gov')
job1 = Job.create(active: 1, start_date: Time.now, end_date: nil, position: 'World Commander', organization: org1, manager: manager1, location: city)
