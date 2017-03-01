require 'yaml'

class SessionsController < ApplicationController
  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Sup, #{@user.name}!"
    rescue
      flash[:warning] = "I am broken..."
    end
    redirect_to root_path
  end

  def auth_failure
    byebug
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'Kick rocks!'
    end
    redirect_to root_path
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
