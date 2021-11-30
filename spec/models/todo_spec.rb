require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'taskの長さが50文字であれば有効な状態であること' do
    todo = FactoryBot.build(:todo, :task_length_50)

    expect(todo).to be_valid
  end

  it 'taskの長さが51文字であれば無効な状態であること' do
    todo = FactoryBot.build(:todo, :task_length_51)

    todo.valid?
    expect(todo.errors[:task]).to include('は50文字以内で入力してください')
  end
end


