FactoryGirl.define do
  factory :user do
    name 'Petr Ivanov'
    sequence(:email) {|n| "user#{n}@tis.com" }
    company 'Horns&Hoofs'
    password '12345678'
    function 'a function'
    www 'http://site.localhost'
  end
end
