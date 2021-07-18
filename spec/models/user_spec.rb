require 'rails_helper'

describe User do

  describe "#create" do

    it 'ユーザー登録ができること' do
      user = User.new
      expect(user.save).to  be_falsey

      user.name = 'taro'
      user.email = 'sample@test.com'
      user.password_digest = 'password'
      expect(user.save).to  be_truthy
    end

    it '重複したメールアドレスは登録ができないこと' do
      user_a = User.new
      user_a.name = 'taro'
      user_a.email = 'sample@test.com'
      user_a.password_digest = 'password'
      expect(user_a.save).to  be_truthy

      user_b = User.new
      user_b.name = 'hanako'
      user_b.email = 'sample@test.com'
      user_b.password_digest = 'password'
      expect(user_b.save).to  be_falsey
    end

    context "値が未入力の場合" do
      it '名前が未入力の場合は登録ができないこと' do
        user = User.new
        user.name = ''
        user.email = 'sample@test.com'
        user.password_digest = 'password'
        expect(user.save).to  be_falsey
      end

      it 'メールアドレスが未入力の場合は登録ができないこと' do
        user = User.new
        user.name = 'taro'
        user.email = ''
        user.password_digest = 'password'
        expect(user.save).to  be_falsey
      end

      it 'パスワードが未入力の場合は登録ができないこと' do
        user = User.new
        user.name = 'taro'
        user.email = 'sample@test.com'
        user.password_digest = ''
        expect(user.save).to  be_falsey
      end
    end

  end
end
