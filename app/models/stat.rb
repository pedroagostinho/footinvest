class Stat < ApplicationRecord
  belongs_to :player
  belongs_to :competition

  validates :games, :goals, :assists, :form, :minutes_played, presence: true
end
