class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :user_signed_in?
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def user_signed_in?
    session[:user_id] 
  end
  def val_once(origin,parent,child,grand,multiple)
#   @error_col << origin.xpath(parent).class
    if origin.xpath("//#{parent}").length == 0
      if grand == 'root'
        @error_col << "Root element #{parent} not found"
      else
        @error_col << "Element #{parent} not found, it should be under #{grand}"

      end
    else
      if origin.xpath("//#{parent}").xpath(child).length == 0
        @error_col << "Element #{child} not found, it should under #{parent}"
      elsif origin.xpath("//#{parent}").xpath(child).length > 1 
        if multiple == false
        @error_col << "Element #{child} is allowed to occr only once"
        end
      end
    end
  end
end
