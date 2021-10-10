class ApplicationController < ActionController::Base
  helper_method :current_user

  def add_flash_message(type, text)
    if type == :notice
      flash[type] ||= []
      flash[type] << text
    else
      flash.now[type] ||= []
      flash.now[type] << text
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def require_logged_in!
    redirect_to sign_in_path if current_user.nil?
  end
end
