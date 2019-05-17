# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

org1 = Organization.create(name: 'The White House', web_page: 'http://www.whitehouse.gov')
city = Location.create(city: 'Washington', admin_level1: 'District of Columbia', country: 'US', point: 0)
obama = People.create(name: 'Barack Obama', organization: org1, position: 'The President', email_address: 'a_made_up_email')
manager1 = Manager.create(organization: org1, people: obama, start_date: Date.new(2008, 1, 25))
job1 = Job.create(
  active: 1,
  start_date: Date.new(2009, 1, 20),
  end_date: nil,
  position: 'President',
  department: 'The Executive Branch',
  organization: org1,
  location: city
)

Description.create(job: job1, text: 'Lead the free world')

Link.create(name: 'github', url: 'https://github.com/WhiteHouse', active: 1)

KeyPoint.create(value: 'root', sort: 1, active: 1, sub_points: [
                  KeyPoint.create(value: 'Skills', sort: 1, active: 1, sub_points: [
                                    KeyPoint.create(value: 'Fun', sort: 1, active: 1),
                                    KeyPoint.create(value: 'Excitment', sort: 2, active: 1)
                                  ])
                ])
