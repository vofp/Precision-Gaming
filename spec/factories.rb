Factory.define :user do |user|
  user.name                   "Michael Hartl"
  user.email                  "mhartl@example.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :topic do |topic|
  topic.name    "Topic name"
  topic.content "Something something dark side"
end

Factory.sequence :name do |n|
  "Topic #{n}"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end

Factory.define :post do |post|
  post.content "Foo bar"
  post.association :user
  post.association :topic
end
