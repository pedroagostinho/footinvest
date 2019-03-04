class Club < ApplicationRecord
  has_many :home_clubs, class_name: "Club", foreign_key: :home_club_id
  has_many :away_clubs, class_name: "Club", foreign_key: :away_club_id
  has_many :news
  has_many :players

  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
end
