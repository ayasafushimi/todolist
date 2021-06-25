require 'rails_helper'

describe 'Todolist', type: :system do

  describe '一覧表示機能' do

    let!(:todo_a) { FactoryBot.create(:todo, task: '最初のtodo', duedate: '202106171700') }

    it '一覧表示画面にtodoが表示されること' do
      visit '/'
      expect(page).to  have_content '最初のtodo'
    end
  end

  describe '詳細表示機能' do

    let!(:todo_a) { FactoryBot.create(:todo, task: '最初のtodo', duedate: '202106171700') }

    it '詳細表示画面に詳細が表示されること' do
      visit todo_path(todo_a)
      expect(page).to  have_content '最初のtodo'
    end
  end

  describe '新規作成機能' do

    let(:valid_task) { '新規作成のテストを書く' }
    let(:empty_task) { '' }
    let(:valid_duedate) { '00202106171700' }
    let(:empty_duedate) { '' }

    before do
      visit new_todo_path
    end

    context '有効な値が入力されたとき' do
      it '正常に登録されること' do
        fill_in 'Task',	with: valid_task
        fill_in 'Duedate', with: valid_duedate
        click_button '登録'
        expect(page).to  have_content '新しいtodoが作成されました'
      end
    end

    context "無効な値が入力されたとき" do
      it 'タスクに空文字が入力されるとエラーメッセージがでること' do
        fill_in 'Task',	with: empty_task
        fill_in 'Duedate', with: valid_duedate
        click_button '登録'
        expect(page).to  have_content 'Taskを入力してください'
      end

      it '期限に空文字が入力されるとエラーメッセージがでること' do
        fill_in 'Task',	with: valid_task
        fill_in 'Duedate', with: empty_duedate
        click_button '登録'
        expect(page).to  have_content 'Duedateを入力してください'
      end
    end
  end

  describe '編集機能' do

    let!(:todo_a) { FactoryBot.create(:todo, task: '最初のtodo', duedate: '202106171700') }
    let(:valid_task) { '編集機能のテストを書く' }

    it 'todoを編集して更新できること' do
      visit todo_path(todo_a)
      click_button '編集'
      fill_in 'Task', with: valid_task
      click_button '更新'
      expect(page).to  have_content 'todoが更新されました'
    end


  end

  describe '削除機能' do

    let!(:todo_a) { FactoryBot.create(:todo, task: '最初のtodo', duedate: '202106171700') }

    it '削除ボタンを押すとtodoが削除されること' do
      visit todo_path(todo_a)
      accept_alert do
        click_button '削除'
      end
      expect(page).to  have_content 'todoが削除されました'
    end
  end

  describe '検索機能' do

    let!(:todo_a) { FactoryBot.create(:todo, task: '最初のtodo', duedate: '202106171700') }

    let(:task) { 'todo' }
    let(:duedate_from) { '00202106010000' }
    let(:duedate_to) { '00202107010000' }

    before do
      visit '/'
    end

    it 'タスクを入力して検索ができること' do
      fill_in 'やること', with: task
      click_button '検索'
      expect(page).to  have_content '最初のtodo'
    end

    it '期限を指定して検索ができること' do
      fill_in 'q[duedate_gteq]', with: duedate_from
      fill_in 'q[duedate_lteq]', with: duedate_to
      click_button '検索'
      expect(page).to  have_content '最初のtodo'
    end
  end


end