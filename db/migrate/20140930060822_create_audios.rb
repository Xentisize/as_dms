class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :audio_file
      t.references :audioable, polymorphic: true

      t.timestamps
    end
  end
end
