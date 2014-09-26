class Subject < ActiveRecord::Base
  has_many :school_documents

  # Simple form's association helper for SchoolDocument
  def to_label
    "#{subject}"
  end
end
