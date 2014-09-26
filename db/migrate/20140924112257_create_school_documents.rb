class CreateSchoolDocuments < ActiveRecord::Migration
  def change
    create_table :school_documents do |t|
      t.string :name
      t.belongs_to :subject
      t.belongs_to :student
      t.integer :year
      t.integer :term
      t.integer :grade

      t.timestamps
    end
  end
end
