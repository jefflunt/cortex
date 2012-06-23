class ApplicationController < ActionController::Base
  helper_method :current_user
  
  protect_from_forgery
  check_authorization
  
  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def redirect_to_page_i_was_on_or_root
      if cookies[:page_i_was_on]
        redirect_to "/#{cookies[:page_i_was_on]}"
        cookies.delete :page_i_was_on
      else
        redirect_to root_url
      end
    end
end
