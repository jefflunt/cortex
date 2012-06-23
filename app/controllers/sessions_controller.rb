class SessionsController < ApplicationController
  skip_authorization_check
  
  def create
    auth = request.env["omniauth.auth"]

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    
    redirect_to_page_i_was_on_or_root
  end

  def destroy
    session[:user_id] = nil
    Rails.logger.info "Redirecting..."
    redirect_to_page_i_was_on_or_root
  end
  
  def failure
    redirect_to_page_i_was_on_or_root
  end
end
