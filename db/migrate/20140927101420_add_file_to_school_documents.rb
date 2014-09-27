class AddFileToSchoolDocuments < ActiveRecord::Migration
  def change
    add_column :school_documents, :file, :string
  end
end
