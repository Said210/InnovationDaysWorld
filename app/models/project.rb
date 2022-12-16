class Project < ApplicationRecord
    belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
    # has_one :user, through: :owner
    has_many :participants
    has_and_belongs_to_many :users, through: :participants

    has_many :technologies, through: :tech_stack

    def tech_stack_names
        TechStack.where(project_id: self.id).joins(:technology).select('technologies.name').map(&:name).join(",")
    end

    def participating_users
        self.participants.map(&:user).join(",")
    end
end
