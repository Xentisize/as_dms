class AddSchoolIdToSchoolDocuments < ActiveRecord::Migration
  def change
    add_reference :school_documents, :school, index: true
  end
end
