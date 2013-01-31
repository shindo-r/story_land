FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password 'password'
    confirmation_token 'hoge'
    confirmed_at Date.current
    confirmation_sent_at Date.current
  end
end