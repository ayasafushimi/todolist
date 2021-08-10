class TodoMailer < ApplicationMailer
  default from: 'todolist@example.com'

  def creation_email(todo)
    @todo = todo
    mail(
      subject: 'Todo作成完了メール',
      to: 'user@example.com',
      from: 'todolist@example.com'
    )
  end
end
