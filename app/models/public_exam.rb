class PublicExam < ActiveRecord::Base
  belongs_to :format
  belongs_to :question_type
end
