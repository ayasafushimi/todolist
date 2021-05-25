class Article < ApplicationRecord
  validates :text, presence: true, length: { maximum: 30}
  validates :date, presence: true
  validates :time, presence: true
end
