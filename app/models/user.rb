class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :buying_users, class_name: "User", foreign_key: :buying_user_id
  has_many :selling_users, class_name: "User", foreign_key: :selling_user_id
  has_many :portfolios
  validates :first_name, :last_name, presence: true
end
