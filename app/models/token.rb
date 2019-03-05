class Token < ApplicationRecord
  belongs_to :player
  has_many :transactions

  validates_inclusion_of :on_sale, in: [true, false]
end
