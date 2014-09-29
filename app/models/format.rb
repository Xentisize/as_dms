class Format < ActiveRecord::Base
  has_many :school_documents
  has_many :public_exams
end
