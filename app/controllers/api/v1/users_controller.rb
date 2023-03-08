class Api::V1::UsersController < ApplicationController
  before_action :authorize_admin, only: %i[index new create destroy]
  before_action :set_users, only: %i[edit update destroy]

  def index
    @users = User.where(role: params[:role])    
  end

  def create
    @user = User.new(users_params)
    if @user.save
      render json: @user, each_serializer: Api::V1::UserSerializer, status: :ok
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit
    
  end

  def update
    if @user.update(users_params)
      render json: @user, each_serializer: Api::V1::UserSerializer, status: :ok
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end    
  end

  def destroy
    if @user.destroy
      render json: @user, each_serializer: Api::V1::UserSerializer, status: :ok
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def import
    file = params[:file]
    ImportUsersService.new(file).call
    render(json: { message: "Activity Data Imported" }, status: :ok)
  end

private

  def set_users
    @user =  User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :role, :avatar_image, :url_image)
  end

  def authorize_admin
    return if current_user.admin?

    render json: { message: "You don't have permission for this action." }
  end

end
