class PublicExam < ActiveRecord::Base
  searchkick
  belongs_to :format
  belongs_to :subject
  belongs_to :publisher
  has_and_belongs_to_many :question_types
  has_many :solutions, :as => :solvable, :dependent => :destroy
  has_many :audios, :as => :audible, :dependent => :destroy

  mount_uploader :file, FileUploader

  include WatermarkDocument
  after_save :watermarked_public_exam

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
