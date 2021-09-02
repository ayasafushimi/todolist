class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @q = User.ransack(params[:q])
    @users = @q.result
  end

  def new
    @user = User.new
  end

    def confirm
    if request.post?
      @user = User.new(user_params)
    else
      @user = User.find(params[:id])
      @user.attributes = user_params
    end

    if @user.valid?
      render action: "confirm"
    else
      render action: request.post? ? "new" : "edit"
    end
  end

  def create
    @user = User.new(user_params)

    if params[:back].present?
      render :new
      return
    end

    if @user.save
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:back].present?
      render :edit
      return
    end

    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :show
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to "/" unless current_user.admin?
  end
end
