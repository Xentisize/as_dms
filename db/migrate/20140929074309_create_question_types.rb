class CreateQuestionTypes < ActiveRecord::Migration
  def change
    create_table :question_types do |t|
      t.string :name

      t.timestamps
    end

    create_table :question_types_school_documents do |t|
      t.belongs_to :question_type
      t.belongs_to :school_document
    end
  end
end
