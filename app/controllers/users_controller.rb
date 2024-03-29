class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_same_user, only: %i[edit update destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5).order(username: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to alpha blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    return if @user.admin?

    @user.destroy
    flash[:danger] = 'User and all articles created by user have been deleted'
    redirect_to users_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    return if (current_user == @user) || current_user.admin?

    flash[:danger] = 'You can only edit your own account'
    redirect_to root_path
  end

  def require_admin
    return if current_user.admin?

    flash[:danger] = 'Only admin users can perform that action'
    redirect_to root_path
  end
end
