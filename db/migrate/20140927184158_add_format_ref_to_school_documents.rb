class AddFormatRefToSchoolDocuments < ActiveRecord::Migration
  def change
    add_reference :school_documents, :format, index: true
  end
end
