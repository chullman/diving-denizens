class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :address

  has_many :user_roles
  has_many :roles, through: :user_roles

  has_many :cart_items

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, presence: true, uniqueness: { case_sensitive: false }


end
