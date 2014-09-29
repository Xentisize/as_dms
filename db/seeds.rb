# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

subjects = %w(Chinese English Mathematics Physics Chemistry Biology IS LS Economics Accounts)
students = ["Jason Law", "Russell Mak", "Andix Chan", "Karinna Lai"]
formats = ["Worksheet", "Test", "Exam", "Mock", "DSE", "HKCEE", "HKALE", "IELTS", "GCSE", "IB", "Others", "Not Specified"]
question_types = ["MC", "Long Questions", "Short Questions", "Open-ended Questions", "Fill in the Blank", "Short Answer", "Long Answer"]

subjects.each do |s|
  Subject.create(subject: s)
end

students.each do |s|
  Student.create(name: s)
end

formats.each do |f|
  Format.create(name: f)
end

question_types.each do |q|
  QuestionType.create(name: q)
end


school_file_path = Rails.root.join("db")
File.open("#{school_file_path}/school.txt").each do |l|
  school = l.split(",")
  School.find_or_create_by(english_name: school[0], chinese_name: school[1].lstrip.chomp)
end