class Article < ApplicationRecord
  validates :text, presence: true, length: { maximum: 30}
  validates :datetime, presence: true

  scope :datetime_between, -> from, to {
    if from.present? && to.present?
      where(:datetime => from..to)
    elsif from.present?
      where("datetime >= ?", from)
    elsif to.present?
      where("datetime <= ?", to)
    else
      all
    end
  }
end
