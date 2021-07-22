class TodosController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

before_action :set_todo, only: [:show, :edit, :update, :destroy, :done]

  def index
    @q = current_user.todos.ransack(params[:q])
    @todos = @q.result.page(params[:page]).per(3)
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = current_user.todos.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: '新しいtodoが作成されました'
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: 'todoが更新されました'
    else
      render :show
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: 'todoが削除されました'
  end

  def done
    @todo.update(state: "done")
    redirect_to todos_path
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end

  private
    def todo_params
      params.require(:todo).permit(:task, :duedate)
    end

    def set_todo
      @todo = current_user.todos.find(params[:id])
    end

end
