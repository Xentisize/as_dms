class CreatePublicExams < ActiveRecord::Migration
  def change
    create_table :public_exams do |t|
      t.integer :year
      t.belongs_to :format
      t.belongs_to :subject
      t.string :publisher
      t.string :file
      t.string :file_location

      t.timestamps
    end

    create_table :public_exams_question_types do |t|
      t.belongs_to :public_exam
      t.belongs_to :question_type
    end
  end
end
