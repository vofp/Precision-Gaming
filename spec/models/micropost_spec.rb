require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = Factory(:user)
    @topic = Factory(:topic)
    @post = @user.posts.create({ :content => "value for content", :topic_id => @topic.id})
    @attr = { :content => "value for content", :post_id => @post.id }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "post associations" do

    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a post attribute" do
      @micropost.should respond_to(:post)
    end

    it "should have the right associated user" do
      @micropost.post_id.should == @post.id
      @micropost.post.should == @post
    end
  end

  describe "validations" do

    it "should require a user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.microposts.build(:content => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.microposts.build(:content => "a" * 141).should_not be_valid
    end
  end
end
