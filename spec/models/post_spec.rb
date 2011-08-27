require 'spec_helper'

describe Post do
  before(:each) do
    @user = Factory(:user)
    @topic = Factory(:topic)
    @attr = { :content => "value for content", :topic_id => @topic.id }
  end

  it "should create a new instance given valid attributes" do
    @user.posts.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @post = @user.posts.create(@attr)
    end

    it "should have a user attribute" do
      @post.should respond_to(:topic)
      @post.should respond_to(:topic_id)
    end

    it "should have a user attribute" do
      @post.should respond_to(:user)
    end

    it "should have a topic attribute" do
      @post.should respond_to(:topic)
    end

    it "should have the right associated user" do
      @post.user_id.should == @user.id
      @post.user.should == @user
    end

    it "should have the right associated topic" do
      @post.topic_id.should == @topic.id
      @post.topic.should == @topic
    end
  end
  describe "validations" do

    it "should require a user id" do
      Post.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.posts.build(:content => "  ").should_not be_valid
    end
  end
end
