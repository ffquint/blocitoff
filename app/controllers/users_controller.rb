class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # @items = @user.items
    unless @user == current_user
      redirect_to :back, :alert => "Access denied,"
    end
  end

end
