class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :edition
end
