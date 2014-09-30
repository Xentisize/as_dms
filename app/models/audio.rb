class Audio < ActiveRecord::Base
  belongs_to :audioable, :polymorphic => true

  mount_uploader :audio_file, AudioUploader
end
