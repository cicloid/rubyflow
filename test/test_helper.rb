ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  include Clearance::TestHelper
end

class ActionController::TestCase
  def self.should_require_login(method, action)
    context "#{method} to #{action} as anonymous" do
      setup do
        send(method, action)
      end
      should_redirect_to 'login_url'
    end
  end
  
  def self.should_require_admin(method, action)
    context "#{method} to #{action} as non-admin user" do
      setup do
        @user = Factory(:user)
        login_as @user
        
        send(method, action)
      end
      should_redirect_to 'login_url'
    end
  end
end