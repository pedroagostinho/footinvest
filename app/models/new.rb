class New < ApplicationRecord
  belongs_to :club
  belongs_to :player

  validates :title, presence: true
  validates :tag, presence: true
  validates :summary, presence: true
end
