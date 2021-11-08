require 'rails_helper'

describe "ログイン機能", type: :system do

  let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
  let!(:guest_user) {FactoryBot.create(:user, name: '太郎', email: 'guest@example.com', password: 'password', password_confirmation: 'password')}

  it '登録したメールアドレスでログインができること' do
    visit '/login'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログインする'
    expect(page).to  have_content 'ログインしました'
  end

  it 'メールアドレス・パスワードの入力なしで、ログインができること' do
    visit '/login'
    click_link_or_button 'かんたんログイン'
    expect(page).to  have_content 'ログインしました'
  end

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
      click_link_or_button 'Logout'
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
      click_link_or_button 'Logout'
    end

    it 'メニューバーにログアウトボタンがないこと' do
      visit '/'
      expect(page).not_to  have_button 'Logout'
    end

    it "タスク一覧画面へ遷移しようとすると、ログイン画面へ遷移されること" do
      visit '/'
      expect(page).to  have_current_path(login_path)
    end
  end
end









