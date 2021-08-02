require 'rails_helper'

describe User, type: :system do

  describe "管理者機能" do

    let!(:not_admin_user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password', admin: false)}

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    context "ユーザーが管理者ではない場合" do
      it "ユーザー登録ができないこと" do
        visit new_admin_user_path
        expect(page).to  have_current_path(root_path)
      end

      it "ユーザー一覧リンクが表示されていないこと" do
        expect(page).not_to  have_content "ユーザー一覧"
      end
    end
  end

  describe '登録機能' do
    let!(:admin_user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password', admin: true)}

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it 'ユーザーが登録できること' do
      click_link_or_button "ユーザー一覧"
      click_link '新規登録'
      fill_in "名前",	with: "花子"
      fill_in "メールアドレス",	with: "test2@example.com"
      fill_in "パスワード",	with: "password"
      fill_in "パスワード(確認)",	with: "password"
      click_button "確認"
      # 確認ボタンを押すと、確認画面が表示されることを確認する
      expect(page).to  have_content '登録内容の確認'
      click_button "戻る"
      # 戻るボタンを押すと、登録画面へ戻ることを確認する
      expect(page).to  have_content 'ユーザー登録'
      fill_in "パスワード",	with: "password"
      fill_in "パスワード(確認)",	with: "password"
      click_button "確認"
      click_button "登録"
      # 登録完了のメッセージが表示されることを確認する
      expect(page).to  have_content 'ユーザー「花子」を登録しました。'
    end

    it 'パスワードが一致していない場合はエラーがでること' do
      click_link_or_button "ユーザー一覧"
      click_link '新規登録'
      fill_in "名前",	with: "花子"
      fill_in "メールアドレス",	with: "test2@example.com"
      fill_in "パスワード",	with: "password"
      fill_in "パスワード(確認)",	with: "password_detarame"
      click_button "確認"
      # エラー文が表示されることを確認する
      expect(page).to  have_content '入力が一致しません'
    end
  end

  describe "編集機能" do

    let!(:admin_user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password', admin: true)}
    let!(:user) {FactoryBot.create(:user, name: '花子', email: 'test2@example.com', password: 'password', password_confirmation: 'password')}

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it 'ユーザー情報を編集できること' do
      click_link_or_button 'ユーザー一覧'
      click_link '花子'
      click_link '編集'
      fill_in "名前",	with: "愛子"
      click_button "確認"
      # 確認ボタンを押すと、確認画面が表示されることを確認する
      expect(page).to  have_content '登録内容の確認'
      click_button "戻る"
      # 戻るボタンを押すと、編集画面へ戻ることを確認する
      expect(page).to  have_content 'ユーザーの編集'
      fill_in "名前",	with: "愛子"
      fill_in "パスワード",	with: "password"
      fill_in "パスワード(確認)",	with: "password"
      click_button "確認"
      click_button "登録"
      # 登録完了のメッセージが表示されることを確認する
      expect(page).to  have_content 'ユーザー「愛子」が更新しました。'
    end
  end

  describe "詳細機能" do

    let!(:admin_user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password', admin: true)}
    let!(:user) {FactoryBot.create(:user, name: '花子', email: 'test2@example.com', password: 'password', password_confirmation: 'password')}

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it 'ユーザー詳細画面へ遷移できること' do
      click_link_or_button 'ユーザー一覧'
      click_link '花子'
      expect(page).to  have_content 'ユーザーの詳細'
    end
  end

  describe "削除機能" do

    let!(:admin_user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password', admin: true)}
    let!(:user) {FactoryBot.create(:user, name: '花子', email: 'test2@example.com', password: 'password', password_confirmation: 'password')}

    before do
      visit '/login'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログインする'
    end

    it "ユーザーを削除できること" do
      click_link_or_button 'ユーザー一覧'
      click_link "花子"
      accept_alert do
        click_link_or_button '削除'
      end
      expect(page).to  have_content 'ユーザー「花子」を削除しました'
    end
  end
end