class Edition < ApplicationRecord
    has_many :projects

    has_many :participants
    has_many :users, through: :participants
    has_many :votes

    def self.current_edition
        Edition.where("begin_at <= ? AND end_at >= ?", DateTime.now, DateTime.now).first || Edition.last
    end

    def current_projects
        Project.where(edition: self)
    end

    def current_participants
        Participant.where(edition: self)
    end
end
