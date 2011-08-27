require 'spec_helper'

describe Topic do
  before(:each) do
    @attr = {:name => "topic1", :content => "This is topic 1"}
  end

  it"should create a new instance given a valid attribute" do
    Topic.create!(@attr)
  end
  
  it "should have a password attribute" do
    topic = Topic.create!(@attr)
    topic.should respond_to(:id)
  end


  it "should require a name" do
    no_name_topic = Topic.new(@attr.merge(:name => ""))
    no_name_topic.should_not be_valid
  end

  it "should require an content" do
    no_content_topic = Topic.new(@attr.merge(:content => ""))
    no_content_topic.should_not be_valid
  end

  it "should reject duplicate name" do
    Topic.create!(@attr)
    topic_with_deplicate_name = Topic.new(@attr)
    topic_with_deplicate_name.should_not be_valid
  end

end
