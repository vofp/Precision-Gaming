require 'spec_helper'

describe Topic do
  before(:each) do
    @attr = {:name => "topic1", :content => "This is topic 1"}
  end

  it"should create a new instance given a valid attribute" do
    Topic.create!(@attr)
  end

  it "should require a name" do
    no_name_topic = Topic.new(@attr.merge(:name => ""))
    no_name_topic.should_not be_valid
  end

  it "should require an content" do
    no_content_topic = Topic.new(@attr.merge(:content => ""))
    no_content_topic.should_not be_valid
  end
end
