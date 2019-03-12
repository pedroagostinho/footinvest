class Competition < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :stats, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  def latest_results
    results.order(date_time: :desc).take(10)
  end
end
