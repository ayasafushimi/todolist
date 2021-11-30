require 'rails_helper'

describe User do

  describe "#create" do

    it '名前、メールアドレス、パスワードがあれば有効な状態であること' do
      user = User.new
      user.name = 'taro'
      user.email = 'sample@test.com'
      user.password_digest = 'password'

      user.valid?
      expect(user).to  be_valid
    end

    it '重複したメールアドレスは登録ができないこと' do
      FactoryBot.create(:user, email: "sample@test.com")

      user = FactoryBot.build(:user, email: "sample@test.com")
      user.valid?
      expect(user.errors[:email]).to  include('はすでに存在します')
    end

    context "値が未入力の場合" do
      it '名前が未入力の場合は登録ができないこと' do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to  include('を入力してください')
      end

      it 'メールアドレスが未入力の場合は登録ができないこと' do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to  include('を入力してください')
      end

      it 'パスワードが未入力の場合は登録ができないこと' do
        user = FactoryBot.build(:user, password_digest: nil)
        user.valid?
        expect(user.errors[:password]).to  include('を入力してください')
      end
    end

  end
end
