class Solution < ActiveRecord::Base
  belongs_to :solvable, :polymorphic => true

  mount_uploader :solution_file, SolutionUploader
end
