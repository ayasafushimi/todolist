class Article < ApplicationRecord
  validates :text, presence: true, length: { maximum: 30}
  validates :date, presence: true, numericality: { message: "は「20XX/XX/XX」のように記入し、「X」には数字を入れてください。（記入例: 2021/06/17）"}
  validates :time, presence: true, numericality: { message: "は「XX：XX」のように記入し、「X」には数字を入れてください。（記入例: 12:00）"}
end
