class TodosController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

before_action :set_todo, only: [:show, :edit, :update, :destroy, :done, :confirm_edit]

  def index
    @q = current_user.todos.ransack(params[:q])
    @todos = @q.result.page(params[:page]).per(3)
  end

  def new
    @todo = Todo.new
  end

  def confirm
    if request.post?
      @todo = current_user.todos.new(todo_params)
    else
      set_todo
      @todo.attributes = todo_params
    end

    if @todo.valid?
      render action: "confirm"
    else
      render action: request.post? ? "new" : "edit"
    end
  end

  def create
    @todo = current_user.todos.new(todo_params)

    if params[:back].present?
      render :new
      return
    end

    if @todo.save
      TodoMailer.creation_email(@todo).deliver_now
      redirect_to @todo, notice: "新しいTodoが作成されました"
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if params[:back].present?
      render :edit
      return
    end

    if @todo.update(todo_params)
      redirect_to @todo, notice: 'Todoが更新されました'
    else
      render :show
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: 'Todoが削除されました'
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
      params.require(:todo).permit(:task, :duedate,:image)
    end

    def set_todo
      @todo = current_user.todos.find(params[:id])
    end

end
