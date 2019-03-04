class Token < ApplicationRecord
  belongs_to :player
  has_many :transactions

  validates :status, presence: true
end
