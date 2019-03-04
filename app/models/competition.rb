class Competition < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :stats, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end
