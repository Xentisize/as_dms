class PublicExam < ActiveRecord::Base
  belongs_to :format
  belongs_to :subject
  belongs_to :publisher
  has_and_belongs_to_many :question_types

  mount_uploader :file, FileUploader

  include WatermarkDocument
  after_save :watermarked_public_exam
end
