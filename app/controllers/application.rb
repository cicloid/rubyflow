# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  include Clearance::ApplicationController
  
  def passes_captcha?(obj)
    result = params[:captcha] && Digest::SHA1.hexdigest(params[:captcha].upcase.chomp)[0..5] == params[:captcha_guide]
    if !result && obj
       obj.errors.add("Word")
    end
    result
  end
  
  def render_404
    render :status => 404, :text => '404 Not Found'
  end
  
  def render_403
    render :status => 403, :text => '403 Forbidden'
  end
  
  def config
    configatron
  end
  
  helper_method :config
  
protected
  # Stuff from restful-authentication, that clearance doesn't provide
  
  def admin?
    logged_in? && current_user.admin == 1
  end
  
  helper_method :admin?
  
  def admin_required
    admin? || deny_access
  end
  
  def login_required
    logged_in? || deny_access
  end
  
  
end
