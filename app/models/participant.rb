class Participant < ApplicationRecord
    belongs_to :user
    belongs_to :project
    belongs_to :edition

    enum role: [:participant, :team_lead]
end
