class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :Confirmable

  has_many :todos, dependent: :destroy

  ROLES = %w[user admin].freeze

  validates :role, inclusion: { in: ROLES }
  # validates :name, presence: true
  # validates :profile, length: { maximum: 200 }

  attr_accessor :current_password
end
