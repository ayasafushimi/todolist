require 'rails_helper'

describe TodoMailer, type: :mailer do
  let!(:user) {FactoryBot.create(:user, name: '太郎', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
  let!(:todo) {user.todos.create(task: 'メイラーテストを書く', duedate: '202106171700')}

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8'}
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8'}
    part.body.raw_source
  end

  describe '#creation_email' do
    let(:mail) { TodoMailer.creation_email(todo) }

    it '想定通りのメールが生成されている' do
      # ヘッダ
      expect(mail.subject).to  eq('Todo作成完了メール')
      expect(mail.to).to  eq(["user@example.com"])
      expect(mail.from).to  eq(["todolist@example.com"])

      # text形式の本文
      expect(text_body).to  match('以下のTodoを作成しました')
      expect(text_body).to  match('メイラーテストを書く')
      expect(text_body).to  match('2021/06/17 17:00')

      # html形式の本文
      expect(html_body).to  match('以下のTodoを作成しました')
      expect(html_body).to  match('メイラーテストを書く')
      expect(html_body).to  match('2021/06/17 17:00')
    end
  end
end
