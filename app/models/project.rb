class Project < ApplicationRecord
    belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
    # has_one :user, through: :owner
    has_many :participants
    has_and_belongs_to_many :users, through: :participants

    has_many :tech_stack
    has_many :technologies, through: :tech_stack

    belongs_to :edition
    has_many :votes

    def tech_stack_names
        TechStack.where(project_id: self.id).joins(:technology).select('technologies.name').map(&:name).join(",")
    end

    def update_tech_stack(new_tech_stack)
        current_stack = TechStack.where(project_id: self.id).joins(:technology).select('technologies.name').map(&:name)
        new_tech_stack = new_tech_stack
        # Make a transaction for creating tech stack
        # And remove the tech stack that is not in the new tech stack
        ActiveRecord::Base.transaction do
            unless new_tech_stack.empty?
                new_tech_stack.each do |tech|
                    technology = Technology.find_or_create_by(name: tech)
                    TechStack.find_or_create_by(project: self, technology: technology)
                end
            end
            current_stack.each do |tech|
                unless new_tech_stack.include?(tech)
                    technology = Technology.find_by(name: tech)
                    TechStack.where(project: self, technology: technology).delete_all
                end
            end
        end
    end

    def participating_users
        self.participants.map(&:user)
    end

    def is_participating?(user)
        self.participants.where(user: user).exists?
    end
end
