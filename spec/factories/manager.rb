FactoryGirl.define do
  factory :manager do
    name 'Ivan Sidorov'
    sequence(:email) {|n| "manager#{n}@tis.com" }
    password '12345678'

    trait :admin do
      admin true
    end
  end
end
