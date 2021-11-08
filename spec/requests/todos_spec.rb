require 'rails_helper'

describe Todo do

  describe "例外処理", type: :request do

    context "存在しないtodoを呼び出したとき" do

      let!(:deleted_todo) { FactoryBot.create(:todo, task: '最初のtodo', duedate: '202106171700') }

      before do
        deleted_todo.destroy
      end

      it "404ステータスが返ってくること" do
        get "/todos/#{deleted_todo.id}"
        expect(response).to  have_http_status(404)
      end
    end
  end
end