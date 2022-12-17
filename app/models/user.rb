class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  enum role: [:participant, :exec, :admin]
  enum skillset: [:developer, :designer, :other]

  has_many :projects
  has_and_belongs_to_many :projects, through: :participants

  has_many :votes
  has_and_belongs_to_many :projects, through: :votes

  has_one_attached :avatar

  #meta program funtions based on role
  User::roles.each do |key, value|
    define_method "#{key}?" do
      self.role == key
    end
  end

  def in_a_project_for?(edition)
    Participant.where(user: self, edition: edition).exists?
  end

  def has_voted_for?(project)
    Vote.where(user: self, project: project).exists?
  end

  def has_voted?
    Vote.where(user: self, edition: Edition.current_edition).exists?
  end

  def hasnt_voted?
    Vote.where(user: self, edition: Edition.current_edition).empty?
  end

  def participates_in?(project)
    Participant.where(user: self, project: project).exists?
  end

  def is_team_leader?(project)
    Participant.where(user: self, project: project, role: :team_lead).exists?
  end
  
end
