class SchoolDocument < ActiveRecord::Base
  searchkick
  belongs_to :subject
  belongs_to :student
  belongs_to :school
  belongs_to :format
  has_many :solutions, :as => :solvable, :dependent => :destroy
  has_many :audios, :as => :audible, :dependent => :destroy
  has_and_belongs_to_many :question_types
  has_and_belongs_to_many :categories
  # accepts_nested_attributes_for :solutions

  mount_uploader :file, FileUploader

  include WatermarkDocument
  after_save :watermarked_school_document

  def search_data
    {
      content: extract_content
    }
  end

  def extract_content
    yomu = Yomu.new file.path
    text = yomu.text
  end

end
