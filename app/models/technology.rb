class Technology < ApplicationRecord
    has_many :projects, through: :tech_stack
end
