require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  should_have_many :stars
  should_have_many :starred_items
  
  include Clearance::UserTest
end
