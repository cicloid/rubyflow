require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase
  should_require_admin :get, :index
  should_require_admin :get, :approve
  should_require_admin :get, :disapprove
  should_require_admin :delete, :destroy
  
  context 'Creating a user' do
    setup do
      @controller.stubs(:passes_captcha?).returns(true)
      @user_attributes = Factory.attributes_for(:user)
      post :create, :user => @user_attributes
      @user = User.find_by_login @user_attributes[:login]
    end
    
    should_redirect_to 'items_url'
    should 'actually create the user' do
      assert_not_nil @user
    end
  end
  
  context 'Failing to create a user' do
    setup do
      @controller.stubs(:passes_captcha?).returns(true)
      @user_attributes = Factory.attributes_for(:user, :password => nil)
      post :create, :user => @user_attributes
      @user = User.find_by_login @user_attributes[:login]
    end
    
    should_respond_with :success
    should_render_template :new
    should 'not actually create the user' do
      assert_nil @user
    end
  end
end
