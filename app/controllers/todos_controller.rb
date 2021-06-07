class TodosController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_todos

  def index
    @q = Todo.ransack(params[:q])
    @todos = @q.result.page(params[:page]).per(3)
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @todo
    else
      render :new
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      redirect_to @todo
    else
      render :show
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    redirect_to todos_path
  end

  def done
    @todo = Todo.find(params[:id])
    @todo.update(state: "done")

    redirect_to todos_path
  end

  def redirect_to_todos
    redirect_to todos_path, notice: 'エラーが発生しました'
  end

  private
    def todo_params
      params.require(:todo).permit(:task, :duedate)
    end

end
