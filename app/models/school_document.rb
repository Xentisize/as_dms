class SchoolDocument < ActiveRecord::Base
  belongs_to :subject
  belongs_to :student
  belongs_to :school
  has_and_belongs_to_many :categories
  mount_uploader :file, FileUploader
  # accepts_nested_attributes_for :categories
  include WatermarkDocument

  after_save :watermarked_the_file
end
