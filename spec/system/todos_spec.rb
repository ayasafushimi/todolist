require 'rails_helper'

describe 'Todolist', type: :system do
  describe '一覧表示機能'
    before do
      todo_a = FactoryBot.create(:todo, task: '最初のタスク')
    end

    context "一覧表示画面へ遷移すると" do
      before do
        visit todos_path
      end

      it '作成したtodoが表示される' do
        expect(page).to  have_content '最初のタスク'
      end
    end
    
end