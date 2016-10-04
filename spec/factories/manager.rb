FactoryGirl.define do
  factory :manager do
    name 'Ivan Sidorov'
    sequence(:email) {|n| "manager#{n}@tis.com" }
    password '12345678'
    password_confirmation '12345678'
    role 'read'

    trait :admin do
      role 'admin'
    end

    trait :write do
      role 'write'
    end
  end
end
