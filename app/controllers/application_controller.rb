class ApplicationController < ActionController::Base
  before_filter  :authenticate_user
  before_filter :current_user
  before_filter :can_access?
  protect_from_forgery
  #protected
  def authenticate_user
    user = User.find_by_id(session[:user_id])
    unless user
      flash[:error] = "Log in"
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    else
      # set current user object to @current_user object variable
      @current_user = user
      return true
    end
  end

  def authenticate_user!
    authenticate_user
  end
  
  def can_access?
    return respond_access_denied unless current_user.admin?
  end
 

  def current_user
    @current_user = User.find_by_id(session[:user_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
    return  @current_user if @current_user
    @current_user= User.new :username => 'guest'
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def user_signed_in?
     if current_user
       return true
     else
       return false
     end
  end
  
  def respond_not_found(msg = 'Not Found')
      respond_with_error(msg, 404)
    end

    def respond_access_denied(msg = 'Access denied')
      respond_with_error(msg, 403)
    end

    def respond_with_error(msg, code = 500, extra_json_keys = {})
      respond_to do |format|
        format.html { render :text => '<p class="error">' + ERB::Util.html_escape(msg) + '</p>', :layout => true, :status => code }
        format.json { render :json => { :error => msg }.merge(extra_json_keys), :status => code }
        format.text { render :text => 'ERROR: ' + msg, :status => code }
        format.zip { render :text => msg, :status => code, :content_type => 'text/plain' }
      end
    end
end
