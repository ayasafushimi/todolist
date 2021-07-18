class Todo < ApplicationRecord
  validates :task, presence: true, length: {maximum: 50, too_ling: "最大%{count}文字まで使えます"}
  validates :duedate, presence: true
  validates :state, presence: true

  belongs_to :user
end
