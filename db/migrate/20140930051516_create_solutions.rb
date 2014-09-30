class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :solution_file
      t.references :solvable, polymorphic: true

      t.timestamps
    end
  end
end
