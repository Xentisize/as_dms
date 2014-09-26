class SchoolDocument < ActiveRecord::Base
  belongs_to :subject
  belongs_to :student
  belongs_to :school
end
