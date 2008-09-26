class UsersController < ApplicationController
  include Clearance::UsersController
  
  before_filter :admin_required, :except => [:new, :create]

  def create
    @user = User.new params[:user]
    if passes_captcha?(@user) && @user.save
      login(@user)
      flash[:notice] = "Thanks for signing up! You have been logged in automagically!"
      redirect_back_or root_url
    else
      render :action => "new"
    end
  end

  def approve
    user = User.find(params[:id])
    user.approved_for_feed = 1
    user.save
    redirect_to :back
  end

  def disapprove
    user = User.find(params[:id])
    user.approved_for_feed = 0
    user.save
    redirect_to :back
  end
  
  def destroy
    return unless request.post?
    User.destroy(params[:id])
  end
end
