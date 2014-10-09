class Audio < ActiveRecord::Base
  belongs_to :audible, :polymorphic => true

  mount_uploader :audio_file, AudioUploader
end
