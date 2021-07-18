require 'rails_helper'

describe "ログイン機能", type: :system do

  let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}

  it '登録したメールアドレスでログインができること' do
    visit '/login'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログインする'
    expect(page).to  have_content 'ログインしました'
  end

  # context "値に空文字が入力されたとき" do
  #   it 'メールアドレスが空文字の場合エラーメッセージがでること' do
  #     visit '/'
  #     click_link_or_button 'ログイン'
  #     fill_in 'メールアドレス', with: ''
  #     fill_in 'パスワード', with: 'password'
  #     cilick_button 'ログインする'
  #     expect(page).to  have_content 'メールアドレスを入力してください'
  #   end

  #   it 'パスワードが空文字の場合エラーメッセージがでること' do
  #     visit '/'
  #     click_link_or_button 'ログイン'
  #     fill_in 'メールアドレス', with: 'test@example.com'
  #     fill_in 'パスワード', with: ''
  #     cilick_button 'ログインする'
  #     expect(page).to  have_content 'パスワードを入力してください'
  #   end
  # end

  # context "データと一致しない値が入力されたとき" do
  #   it 'パスワードが正しくない場合ログインができないこと' do
  #     visit '/'
  #     click_link_or_button 'ログイン'
  #     fill_in 'メールアドレス', with: 'test@example.com'
  #     fill_in 'パスワード', with: 'detarame'
  #     cilick_button 'ログインする'
  #     expect(page).to  have_content 'メールアドレスまたはパスワードが正しくありません'
  #   end

  #   it '登録していないメールアドレスでログインができないこと' do
  #     visit '/'
  #     click_button 'ログイン'
  #     fill_in 'メールアドレス', with: 'detarame@example.com'
  #     fill_in 'パスワード', with: 'password'
  #     cilick_button 'ログインする'
  #     expect(page).to  have_content 'メールアドレスまたはパスワードが正しくありません'
  #   end
  # end
end

describe "ログアウト機能" do

  let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}

  context "ログイン状態のとき" do

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it 'ログアウトができる' do
      visit '/'
      click_link_or_button 'ログアウト'
      expect(page).to  have_content 'ログアウトしました'
    end
  end

  context "ログアウト状態のとき" do

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
      visit '/'
      click_link_or_button 'ログアウト'
    end

    it 'メニューバーにログアウトボタンがないこと' do
      visit '/'
      expect(page).not_to  have_button 'ログアウト'
    end

    it "タスク一覧画面へ遷移しようとすると、ログイン画面へ遷移されること" do
      visit '/'
      expect(page).to  have_current_path(login_path)
    end
  end
end









