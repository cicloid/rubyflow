require File.dirname(__FILE__) + '/../test_helper'

class ItemTest < ActiveSupport::TestCase
  should_belong_to :user
  should_have_many :comments
  should_have_many :stars
  
  should_ensure_length_in_range :title, (4..255)
  should_ensure_length_in_range :name, (4..255)
  should_ensure_length_in_range :content, (25..1200)
  should_ensure_length_in_range :byline, (0..18)
  
  # TODO test tagging stuff
  
  context 'An Item' do
    setup do
      @item = Factory(:item, :name => 'ihasname')
    end
    
    should_require_unique_attributes :name
    
    should_allow_values_for :name, 'name-1', 'name_1'
    should_not_allow_values_for :name, 'name 1', :message => 'is invalid (alphanumerics, hyphens and underscores only)'
    
    should 'use name for #to_param' do
      assert_equal @item.name, @item.to_param
    end
    
    context 'that has been starred by a user' do
      setup do
        @user = Factory(:user)
        @user.stars.create(:item => @item)
      end
      
      should 'be starred by user' do
        assert @item.is_starred_by_user(@user)
      end
      
      should 'generate starred css class' do
        assert_equal 'starred', @item.starred_class(@user)
      end
    end
    
    context 'that has not been starred by a user' do
      setup do
        @user = Factory(:user)
      end
      
      should 'be starred by user' do
        assert !@item.is_starred_by_user(@user)
      end
      
      should 'generate empty css class' do
        assert_equal '', @item.starred_class(@user)
      end
    end
  end
  
  context 'An Item with a nil byline and user_id' do
    setup do 
      @item = Factory.build(:item, :byline => nil, :user => nil)
    end
    
    should 'be anonymous' do
      assert @item.anonymous?
    end
    
    context 'when saved' do
      setup do
        @item.save
      end
      
      should 'have byline of Anonymous Coward' do
        assert_equal 'Anonymous Coward', @item.byline
      end
      
      should 'still be anonymous' do
        assert @item.anonymous?
      end
    end
  end
  
  context 'An Item without a name' do
    setup do
      @item = Factory(:item, :name => nil)
    end
    
    should 'use id for #to_param' do
      assert_equal @item.id, @item.to_param
    end
  end
end