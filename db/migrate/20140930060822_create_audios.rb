class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :audio_file
      t.references :audible, polymorphic: true

      t.timestamps
    end
  end
end
