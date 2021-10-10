class SessionsController < ApplicationController
  def new; end
  def create
    user = User.find_by(username: params[:username])

    if user.present? && user.authenticate(params[:password])

      session[:user_id] = user.id
      redirect_to pictures_path
    else
      add_flash_message :alert, 'ユーザーIDを入力してください' if params[:username].blank?
      add_flash_message :alert, 'パスワードを入力してください' if params[:password].blank?
      add_flash_message :alert, 'ユーザーIDとパスワードは一致していません' if user.present? && !user.authenticate(params[:password])
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
