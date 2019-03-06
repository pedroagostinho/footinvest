class Player < ApplicationRecord
  include PgSearch
  pg_search_scope :global_search,
  against: [:name, :position],
  associated_against: {
      club: [:name, :city]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  belongs_to :club
  has_many :stats
  has_many :tokens
  has_many :news
  has_many :market_values

  validates :name, :nationality, :position, :social_url, :age, :height, presence: true
end
