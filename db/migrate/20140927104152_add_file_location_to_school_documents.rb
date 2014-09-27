class AddFileLocationToSchoolDocuments < ActiveRecord::Migration
  def change
    add_column :school_documents, :file_location, :string
  end
end
