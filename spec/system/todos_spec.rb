require 'rails_helper'

describe Todo, type: :system do

  describe '一覧表示機能' do

    let!(:logged_in_user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
    let!(:not_logged_in_user) {FactoryBot.create(:user, name: '花子', email: 'test2@example.com', password: 'password', password_confirmation: 'password')}

    before do
      logged_in_user.todos.create(task: 'このtodoはみられるよ', duedate: '202106171700')
      not_logged_in_user.todos.create(task: 'このtodoはみられないよ', duedate: '202106171700')
    end

    it "ログインしているユーザーのtodoのみが表示されること" do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
      visit "/todos"
      expect(page).to  have_content 'このtodoはみられるよ'
      expect(page).not_to  have_content 'このtodoはみられないよ'
    end
  end

  describe '詳細表示機能' do

    let!(:logged_in_user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
    let!(:not_logged_in_user) {FactoryBot.create(:user, name: '花子', email: 'test2@example.com', password: 'password', password_confirmation: 'password')}

    before do
      @logged_in_user_todo = logged_in_user.todos.create(task: 'このtodoはみられるよ', duedate: '202106171700')
      @not_logged_in_user_todo = not_logged_in_user.todos.create(task: 'このtodoはみられないよ', duedate: '202106171700')
      @linked_todo = logged_in_user.todos.create(task: 'https://www.yahoo.co.jp/', duedate: '202106171700')

      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it 'ログインしているユーザーのtodo詳細が表示されること' do
      visit todo_path(@logged_in_user_todo)
      expect(page).to  have_content 'このtodoはみられるよ'
    end

    it "他ユーザーのtodo詳細が表示されないこと" do
      visit todo_path(@not_logged_in_user_todo)
      expect(page).to  have_content '404 Not Found'
    end

    it "テキストに貼ったリンク先をクリックすると、リンク先へ遷移できること" do
      visit todo_path(@linked_todo)
      click_link "https://www.yahoo.co.jp/"
      expect(page).to  have_content "Yahoo! JAPAN"
    end
  end

  describe '新規作成機能' do

    let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}

    let(:valid_task) { '新規作成のテストを書く' }
    let(:empty_task) { '' }
    let(:valid_duedate) { '00202106171700' }
    let(:empty_duedate) { '' }

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
      visit new_todo_path
    end

    context '有効な値が入力されたとき' do
      it '正常に登録されること' do
        fill_in 'Todo',	with: valid_task
        fill_in '締め切り日', with: valid_duedate
        click_link_or_button '確認'
        click_link_or_button '登録'
        # 登録完了のメッセージが表示されることを確認する
        expect(page).to  have_content '新しいTodoが作成されました'
      end
    end

    context "無効な値が入力されたとき" do
      it 'タスクに空文字が入力されるとエラーメッセージがでること' do
        fill_in 'Todo',	with: empty_task
        fill_in '締め切り日', with: valid_duedate
        click_link_or_button '確認'
        expect(page).to  have_content "#{Todo.human_attribute_name(:task)}を入力してください"
      end

      it '期限に空文字が入力されるとエラーメッセージがでること' do
        fill_in 'Todo',	with: valid_task
        fill_in '締め切り日', with: empty_duedate
        click_link_or_button '確認'
        expect(page).to  have_content "#{Todo.human_attribute_name(:duedate)}を入力してください"
      end
    end
  end

  describe '編集機能' do

    let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
    let(:valid_task) { '編集機能のテストを書く' }

    before do
      @todo = user.todos.create(task: '編集されちゃうよ', duedate: '202106171700')
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it 'todoを編集して更新できること' do
      visit todo_path(@todo)
      click_link_or_button '編集'
      fill_in 'Todo', with: valid_task
      click_button '確認'
      click_button '登録'
      # 更新完了のメッセージが表示されることを確認する
      expect(page).to  have_content 'Todoが更新されました'
    end

    it '確認画面で戻るボタンを押すと、編集画面へ遷移すること' do
        visit todo_path(@todo)
        click_link_or_button '編集'
        fill_in 'Todo',	with: valid_task
        click_button '確認'
        click_button '戻る'
        expect(page).to  have_content 'Todoの編集'
      end


  end

  describe '削除機能' do

    let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
    let!(:todo) {user.todos.create(task: '削除されちゃうよ', duedate: '202106171700')}

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it '削除ボタンを押すとtodoが削除できること' do
      visit todo_path(todo)
      accept_alert do
        click_link_or_button '削除'
      end
      expect(page).to  have_content 'Todoが削除されました'
    end
  end

  describe '検索機能' do

    let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
    let!(:todo) {user.todos.create(task: '検索されちゃうよ', duedate: '202106171700')}
    let(:task) { '検索' }
    let(:duedate_from) { '00202106010000' }
    let(:duedate_to) { '00202107010000' }

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
      visit '/'
    end

    it 'タスクを入力して検索ができること' do
      fill_in 'やること', with: task
      click_button '検索'
      expect(page).to  have_content '検索されちゃうよ'
    end

    it '期限を指定して検索ができること' do
      fill_in 'q[duedate_gteq]', with: duedate_from
      fill_in 'q[duedate_lteq]', with: duedate_to
      click_button '検索'
      expect(page).to  have_content '検索されちゃうよ'
    end
  end


end