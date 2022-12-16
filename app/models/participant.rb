class Participant < ApplicationRecord
    belongs_to :user
    belongs_to :project

    enum role: [:participant, :team_lead]
end
