# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

subjects = %w(Chinese English Mathematics Physics Chemistry Biology IS LS Economics Accounts)
students = ["Jason Law", "Russell Mak", "Andix Chan", "Karinna Lai"]

subjects.each do |s|
  Subject.create(subject: s)
end

students.each do |s|
  Student.create(name: s)
end