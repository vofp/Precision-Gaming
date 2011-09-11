require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:name => "example User", :email => "user@example.com", :password => "password", :password_confirmation => "password"}
  end

  it"should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@FOO.JP]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com THE_USER_at_foo.bar.org first.last@FOO. first@.com]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should_not be_valid
    end
  end
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_deplicate_email = User.new(@attr)
    user_with_deplicate_email.should_not be_valid
  end

  it "should reject duplicate email addresses identical up to case" do
    User.create!(@attr)
    user_with_deplicate_email = User.new(@attr.merge(:email => "USER@EXAMPLE.COM"))
    user_with_deplicate_email.should_not be_valid
  end

  describe "passwords" do
    
    before(:each) do
      @user = User.new(@attr)
    end
    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

    it "should have a salt" do
      @user.should respond_to(:salt)
    end

    describe "has_password? method" do
      it "should exist" do
        @user.should respond_to(:has_password?)
      end
      it "should return true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      it "should return false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticat method" do
      it "should exist" do
        User.should respond_to(:authenticate)
      end
      it "should return nill on email/password mismatch" do
        User.authenticate(@attr[:email],"wrongpass").should be_nil
      end
      it "should return nil for an email address with no user" do
        User.authenticate("invalid@invalid.com", @attr[:password]).should be_nil
      end
      it "should return the user on email/password match" do
        User.authenticate(@attr[:email],@attr[:password]).should == @user
      end
    end

  end
  
  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
    
  describe "micropost associations" do

    before(:each) do
      @user = User.create(@attr)
      @mp1 = Factory(:micropost, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:microposts)
    end
    
    it "should have the right microposts in the right order" do
      @user.microposts.should == [@mp2, @mp1]
    end
    
    it "should destroy associated microposts" do
      @user.destroy
      [@mp1, @mp2].each do |micropost|
        lambda do 
          Micropost.find(micropost.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "status feed" do

      it "should have a feed" do
        @user.should respond_to(:feed)
      end

      it "should include the user's microposts" do
        @user.feed.include?(@mp1).should be_true
        @user.feed.include?(@mp2).should be_true
      end

      it "should not include a different user's microposts" do
        mp3 = Factory(:micropost,
                      :user => Factory(:user, :email => Factory.next(:email)))
        @user.feed.include?(mp3).should be_false
      end
    end
    
  end

  describe "post associations" do

    before(:each) do
      @user = User.create(@attr)
      @topic = Factory(:topic)
      @p1 = Factory(:post, :user => @user, :topic => @topic, :created_at => 1.day.ago)
      @p2 = Factory(:post, :user => @user, :topic => @topic, :created_at => 1.hour.ago)
    end

    it "should have a posts attribute" do
      @user.should respond_to(:posts)
    end
    
    it "should have the right posts in the right order" do
      @user.posts.should == [@p2, @p1]
    end
    
    it "should destroy associated posts" do
      @user.destroy
      [@p1, @p2].each do |post|
        lambda do 
          Post.find(post.id)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end
end
