class SessionsController < ApplicationController
  skip_authorization_check
  
  def create
    auth = request.env["omniauth.auth"]

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    
    
    if cookies[:page_i_was_on].nil?
      redirect_to root_url
    else
      redirect_to cookies[:page_i_was_on]
      cookies.delete :page_i_was_on
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out."
    redirect_to root_url, :notice => "Signed out."
  end
  
  def failure
    redirect_to root_url
  end
end
