class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, presence: true

  has_many :buying_users, class_name: "User", foreign_key: :buying_user_id
  has_many :selling_users, class_name: "User", foreign_key: :selling_user_id
  has_many :portfolios

  before_create :set_balance

  private

  def set_balance
    self.balance = 200
  end
end
