class Player < ApplicationRecord
  belongs_to :club
  has_many :stats
  has_many :tokens
  has_many :news
  has_many :market_values

  validates :name, :nationality, :position, :social_url, :age, :height, presence: true
end
