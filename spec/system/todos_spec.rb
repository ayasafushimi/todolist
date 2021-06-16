require 'rails_helper'

describe 'Todolist', type: :system do
  let!(:todo_a) { FactoryBot.create(:todo, task: '最初のtodo', duedate: '202106171700') }

  describe '一覧表示機能' do

    context '一覧表示画面へ遷移すると' do
      before do
        visit '/'
      end

      it 'todoが表示される' do
        expect(page).to  have_content '最初のtodo'
      end
    end
  end

  describe '詳細表示機能' do

    context 'todo詳細表示画面へ遷移すると' do
      before do
        visit todo_path(todo_a)
      end
      
      it '詳細が表示される' do
        expect(page).to  have_content '最初のtodo'
      end
    end
  end

  describe '新規作成機能' do
    
    before do
      visit new_todo_path
      fill_in 'Task',	with: task
      fill_in 'Duedate',	with: duedate
      click_button '登録'
    end

    context '新規作成画面でtaskとduedateを入力したとき' do
      let(:task) { '新規作成のテストを書く' }
      let(:duedate) { '00202106171700' }

      it '正常に登録される' do
        expect(page).to  have_content '新しいtodoが作成されました'
      end
    end

    context "新規作成画面でtaskを入力しなかったとき" do
      let(:task) { '' }
      let(:duedate) { '00202106171700' }

      it 'エラーが発生する' do
        expect(page).to  have_content 'Taskを入力してください'
      end
    end
    
    context "新規作成画面でduedateを入力しなかったとき" do
      let(:task) { '新規作成のテストを書く' }
      let(:duedate) { '' }

      it 'エラーが発生する' do
        expect(page).to  have_content 'Duedateを入力してください'
      end
    end
  end

  describe '編集機能' do

    before do
      visit todo_path(todo_a)
      click_button '編集'
      fill_in 'Task', with: task
      click_button '更新'
    end

    context '編集画面でtaskを入力したとき' do
      let(:task) { '編集機能のテストを書く' } 

      it 'todoが更新される' do
        expect(page).to  have_content 'todoが更新されました'
      end
    end
    
  end

  describe '削除機能' do

    before do
      visit todo_path(todo_a)
    end

    context '削除ボタンを押したとき' do
      before do
        accept_alert do
          click_button '削除'
        end
      end

      it 'todoが削除される' do
        expect(page).to  have_content 'todoが削除されました'
      end
    end
  end

  describe '検索機能' do

    before do
      visit '/'
      fill_in 'やること', with: task
      fill_in 'q[duedate_gteq]', with: duedate_from
      fill_in 'q[duedate_lteq]', with: duedate_to
      click_button '検索'
    end
    
    context 'Taskを入力して検索すると' do
      let(:task) { 'todo' }
      let(:duedate_from) { '' }
      let(:duedate_to) { '' } 

      it '該当のtodoが表示される' do
        expect(page).to  have_content '最初のtodo'
      end
    end

    context 'Duedateを入力して検索すると' do
      let(:task) { '' } 
      let(:duedate_from) { '00202106010000' }
      let(:duedate_to) { '00202107010000' }

      it '該当のtodoが表示される' do
        expect(page).to  have_content '最初のtodo'
      end
    end
  end


end