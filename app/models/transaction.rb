class Transaction < ApplicationRecord
  belongs_to :token
  belongs_to :buying_user, class_name: "User"
  belongs_to :selling_user, class_name: "User", optional: true

  validates :date_time, :price, presence: true
end
