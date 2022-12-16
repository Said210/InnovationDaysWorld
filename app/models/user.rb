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
end
