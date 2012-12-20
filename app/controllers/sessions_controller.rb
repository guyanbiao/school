class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.where(email: auth['info']['email']).first || User.create_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path, :notice => "Welcome #{auth['info']['name']}"
  end
  def failue
    redirect_to root_path, :alert => 'authentication falil'
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'Logout successfully'
  end
end
