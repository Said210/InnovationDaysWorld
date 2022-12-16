class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable

  enum role: [:participant, :exec, :administrator]
  enum skillset: [:developer, :designer, :other]
  
  has_and_belongs_to_many :projects, through: :participants

  has_one_attached :avatar
end
