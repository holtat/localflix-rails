class Api::V1::UsersController < ApplicationController
  before_action :set_user_from_params, only: :show

  def index
    render json: User.all, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    user = User.new(create_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

private

  def set_user_from_params
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def create_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
