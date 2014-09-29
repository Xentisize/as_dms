class SchoolDocument < ActiveRecord::Base
  belongs_to :subject
  belongs_to :student
  belongs_to :school
  belongs_to :format
  has_and_belongs_to_many :question_types
  has_and_belongs_to_many :categories
  mount_uploader :file, FileUploader

  include WatermarkDocument
  after_save :watermarked_the_file

end
