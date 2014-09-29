class CreatePublicExams < ActiveRecord::Migration
  def change
    create_table :public_exams do |t|
      t.integer :year
      t.belongs_to :format
      t.string :subject

      t.timestamps
    end
  end
end
