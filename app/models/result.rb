class Result < ApplicationRecord
  belongs_to :competition
  belongs_to :home_club, class_name: "Club"
  belongs_to :away_club, class_name: "Club"

  validates :home_club_goals, presence: true
  validates :away_club_goals, presence: true
end
