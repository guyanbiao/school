class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    user = User.where(email: auth['info']['email']).first || User.create_from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to '/home', :notice => "Welcome #{user.name} "
  end
  def failue
    redirect_to '/home', :alert => 'authentication falil'
  end
  def destroy
    session[:user_id] = nil
    redirect_to '/home', :notice => 'Logout successfully'
  end
end
