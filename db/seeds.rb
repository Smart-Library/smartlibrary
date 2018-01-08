# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

carleton = Grouping.create name: 'Carleton'
library = Grouping.create name: 'Library', parent_grouping: carleton
floor1 = Grouping.create name: '1st Floor', parent_grouping: library
floor2 = Grouping.create name: '2nd Floor', parent_grouping: library
floor3 = Grouping.create name: '3rd Floor', parent_grouping: library

Desk.create name: 'Desk 101', grouping: floor1, occupied: false
Desk.create name: 'Desk 102', grouping: floor1, occupied: true
Desk.create name: 'Desk 103', grouping: floor1, occupied: false

Desk.create name: 'Desk 201', grouping: floor2, occupied: true
Desk.create name: 'Desk 202', grouping: floor2, occupied: false
Desk.create name: 'Desk 203', grouping: floor2, occupied: false

Desk.create name: 'Desk 301', grouping: floor3, occupied: false
Desk.create name: 'Desk 302', grouping: floor3, occupied: true
Desk.create name: 'Desk 303', grouping: floor3, occupied: true

Desk.create name: 'Bench in Quad', grouping: carleton, occupied: false

(Grouping.all + Desk.all).each do |elem|
  elem.create_coordinate(x: rand(0..500), y: rand(0..500))
  elem.save
end
