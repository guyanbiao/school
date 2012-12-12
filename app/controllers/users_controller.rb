class UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
    @user.level = params[:level]
    @user.save
  end

end
