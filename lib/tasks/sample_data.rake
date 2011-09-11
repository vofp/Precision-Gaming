
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    require 'faker'
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    Topic.create!(:name => "Important", :content => "Important updates will be listed under here")
    Topic.create!(:name => "Events", :content => "Events will be listed under here")
    Topic.create!(:name => "Casts", :content => "Uploaded cast games will be listed under here")
    Topic.create!(:name => "Replays", :content => "Replay files will be listed under here")
    Topic.create!(:name => "Others", :content => "Everything else will be listed under here")
    User.all(:limit => 6).each do |user|
      50.times do
        user.posts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end
