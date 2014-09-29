class QuestionType < ActiveRecord::Base
  has_and_belongs_to_many :school_documents
  has_and_belongs_to_many :public_exams
end
