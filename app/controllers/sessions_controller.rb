class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]

  def login
    #Login Form
    flash.now
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome again, you logged in as #{authorized_user.username}"
      redirect_to(:action => 'home')
      #debugger
    else
      flash[:error] = "Invalid Username or Password" unless flash[:error] 
      render "login"
    end
  end


  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

  def home
  end

  def profile
  end

  def setting
  end
end
