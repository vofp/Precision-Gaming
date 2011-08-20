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

end
