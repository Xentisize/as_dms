class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :english_name
      t.string :chinese_name

      t.timestamps
    end
  end
end
